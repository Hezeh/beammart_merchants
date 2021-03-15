import 'package:beammart_merchants/screens/add_images_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../models/auth_user.dart';
import '../providers/auth_provider.dart';
import '../screens/item_detail.dart';
import '../widgets/drawer.dart';
import 'package:shimmer/shimmer.dart';

final GoogleSignIn googleUserIn = GoogleSignIn();
final CollectionReference profileRef =
    FirebaseFirestore.instance.collection('profile');

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAuth = false;
  final usersRef = FirebaseFirestore.instance.collection('users');
  AuthUser currentUser;
  final DateTime timestamp = DateTime.now();

  _addItem(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddImagesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: LeftDrawer(),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu_outlined),
                iconSize: 30.0,
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
            ],
          ),
        ),
        body: HomePage(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () => _addItem(context),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<AuthenticationProvider>(context);

    final Stream<QuerySnapshot> items = FirebaseFirestore.instance
        .collection('profile')
        .doc(_userProvider.user.uid)
        .collection('items')
        .orderBy('dateAdded', descending: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: items,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error occurred while loading the app'),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return (snapshot.data.docs.isNotEmpty)
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 5,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 500,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GridTile(
                                footer: GridTileBar(
                                  backgroundColor: Colors.black38,
                                  trailing: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Confirm Delete'),
                                              content: const Text(
                                                'Do you really want to delete this product?',
                                              ),
                                              actions: [
                                                OutlineButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: const Text('Cancel'),
                                                ),
                                                RaisedButton(
                                                  onPressed: () {
                                                    snapshot.data.docs[index]
                                                        .reference
                                                        .delete();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                      '${snapshot.data.docs[index].data()['title']}'),
                                ),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemDetail(
                                        item: Item.fromJson(
                                          snapshot.data.docs[index].data(),
                                        ),
                                        itemId: snapshot.data.docs[index].id,
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data.docs[index]
                                          .data()['images']
                                          .first,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            colorFilter: ColorFilter.mode(
                                              Colors.white,
                                              BlendMode.colorBurn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        child: Card(
                                          child: Container(
                                            width: double.infinity,
                                            height: 300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text('No products posted yet'),
                  );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
