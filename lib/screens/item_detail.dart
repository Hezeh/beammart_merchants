import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/screens/add_images_screen.dart';
import 'package:beammart_merchants/screens/payments_subscriptions_screen.dart';
import 'package:beammart_merchants/widgets/item_analytics_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/item.dart';
import '../providers/auth_provider.dart';
import '../widgets/display_images_widget.dart';

class ItemDetail extends StatefulWidget {
  final Item? item;
  final String itemId;
  static const routeName = '/item-detail';

  ItemDetail({
    Key? key,
    this.item,
    required this.itemId,
  }) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  final TextEditingController _editTitleController = TextEditingController();
  final TextEditingController _editDescController = TextEditingController();
  final TextEditingController _editPriceController = TextEditingController();
  final _itemDetailFormKey = GlobalKey<FormState>();
  bool? _inStock;

  @override
  void dispose() {
    _editDescController.dispose();
    _editTitleController.dispose();
    _editPriceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _editTitleController.text = widget.item!.title!;
    _editDescController.text = widget.item!.description!;
    _editPriceController.text = widget.item!.price.toString();
    _inStock = widget.item!.inStock;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<AuthenticationProvider>(context);
    final _subsProvider = Provider.of<SubscriptionsProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item Details'),
          actions: [
            TextButton(
              onPressed: () {
                if (_itemDetailFormKey.currentState!.validate()) {
                  final String _userId = _userProvider.user!.uid;
                  final DocumentReference _doc = FirebaseFirestore.instance
                      .collection('profile')
                      .doc(_userId)
                      .collection('items')
                      .doc(widget.itemId);

                  _doc.set({
                    'title': _editTitleController.text,
                    'description': _editDescController.text,
                    'price': double.parse(_editPriceController.text),
                    'inStock': _inStock
                  }, SetOptions(merge: true));

                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.edit_outlined,
                ),
                child: Semantics(
                  child: Text('Edit'),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.analytics_outlined,
                ),
                child: Semantics(
                  child: Text('Analytics'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Form(
              key: _itemDetailFormKey,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Center(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AddImagesScreen(
                                editing: true,
                                itemId: widget.itemId,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_outlined,
                        ),
                        label: Text('Add Photos'),
                      ),
                    ),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('profile')
                        .doc(_userProvider.user!.uid)
                        .collection('items')
                        .doc(widget.itemId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        height: 400,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1.3,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.data()!['images'].length,
                          itemBuilder: (context, index) {
                            List<dynamic> _removeList = [];
                            _removeList
                                .add(snapshot.data!.data()!['images'][index]);
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: GridTile(
                                  footer: (snapshot.data!
                                              .data()!['images']
                                              .length >
                                          1)
                                      ? GridTileBar(
                                          backgroundColor: Colors.black45,
                                          trailing: IconButton(
                                            icon: Icon(
                                                Icons.delete_outline_outlined),
                                            onPressed: () {
                                              if (_removeList.isNotEmpty) {
                                                FirebaseFirestore.instance
                                                    .collection('profile')
                                                    .doc(
                                                        _userProvider.user!.uid)
                                                    .collection('items')
                                                    .doc(widget.itemId)
                                                    .set(
                                                  {
                                                    'images':
                                                        FieldValue.arrayRemove(
                                                            _removeList)
                                                  },
                                                  SetOptions(merge: true),
                                                );
                                              }
                                            },
                                          ),
                                        )
                                      : Container(),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.data()!['images']
                                        [index],
                                    height: 500,
                                    width: 200,
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
                                      child: Card(
                                        child: Container(
                                          width: double.infinity,
                                          height: 300,
                                          color: Colors.white,
                                        ),
                                      ),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _editTitleController,
                      autocorrect: true,
                      enableSuggestions: true,
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Edit Title',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _editDescController,
                      autocorrect: true,
                      enableSuggestions: true,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Edit Description',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _editPriceController,
                      autocorrect: true,
                      enableSuggestions: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Edit Price',
                      ),
                    ),
                  ),
                  MergeSemantics(
                    child: ListTile(
                      title: Text('Item in Stock'),
                      trailing: CupertinoSwitch(
                        value: _inStock!,
                        onChanged: (bool value) {
                          setState(() {
                            _inStock = value;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _inStock = !_inStock!;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 25,
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_itemDetailFormKey.currentState!.validate()) {
                          final String _userId = _userProvider.user!.uid;
                          final DocumentReference _doc = FirebaseFirestore
                              .instance
                              .collection('profile')
                              .doc(_userId)
                              .collection('items')
                              .doc(widget.itemId);

                          _doc.set({
                            'title': _editTitleController.text,
                            'description': _editDescController.text,
                            'price': double.parse(_editPriceController.text),
                            'inStock': _inStock
                          }, SetOptions(merge: true));

                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   child: (_subsProvider.purchases.isEmpty)
            //       ? Center(
            //           child: OutlinedButton(
            //             child: Text('Get Premium'),
            //             onPressed: () {
            //               Navigator.of(context).push(
            //                 MaterialPageRoute(
            //                   builder: (_) => PaymentsSubscriptionsScreen(),
            //                 ),
            //               );
            //             },
            //           ),
            //         )
            //       // : ItemAnalyticsWidget(
            //       //     itemId: widget.itemId,
            //       //   ),
            // ),
            Container(
              child: ItemAnalyticsWidget(
                itemId: widget.itemId,
              ),
            )
          ],
        ),
      ),
    );
  }
}
