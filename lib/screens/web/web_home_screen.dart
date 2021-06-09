import 'package:beammart_merchants/enums/device_size.dart';
import 'package:beammart_merchants/screens/web/web_analytics_screen.dart';
import 'package:beammart_merchants/screens/web/web_item_detail_screen.dart';
import 'package:flutter/material.dart';

const appBarDesktopHeight = 50.0;

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  _WebHomeScreenState createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  int _selectedIndex = 0;

  updateSelectedIndex(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = getFormFactor(context) == ScreenType.Desktop;
    if (_selectedIndex == 1) {
      body = WebAnalyticsScreen();
    } else if (_selectedIndex == 2) {
      body = Container(
        child: Text("Other"),
      );
    } else {
      body = SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: ListView(
            children: [
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                // itemCount: snapshot.data!.docs.length,
                itemCount: 20,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  // childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black38,
                          trailing: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline_outlined,
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Delete'),
                                      content: const Text(
                                        'Do you really want to delete this product?',
                                      ),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // snapshot.data!.docs[index].reference
                                            //     .delete();
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
                          // title: Text(
                          //     '${snapshot.data!.docs[index].data()!['title']}'),
                          title: Text("Title"),
                        ),
                        child: InkWell(
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ItemDetail(
                          //       item: Item.fromJson(
                          //         snapshot.data!.docs[index].data()!,
                          //       ),
                          //       itemId: snapshot.data!.docs[index].id,
                          //     ),
                          //     settings: RouteSettings(
                          //       name: 'MerchantItemDetailScreen',
                          //     ),
                          //   ),
                          // ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => WebItemDetailScreen(),
                              ),
                            );
                          },
                          child: Image.network(
                            "https://images.unsplash.com/photo-1593642634315-48f5414c3ad9?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    }

    if (isDesktop) {
      return Row(
        children: [
          ListDrawer(
            selectedIndex: this.updateSelectedIndex,
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
              appBar: const AdaptiveAppBar(
                isDesktop: true,
              ),
              body: body,
              floatingActionButton: FloatingActionButton.extended(
                heroTag: 'Add Item',
                onPressed: () {},
                label: Text(
                  "Add Item",
                  style: TextStyle(color: colorScheme.onSecondary),
                ),
                icon: Icon(Icons.add, color: colorScheme.onSecondary),
                tooltip: "Add Item",
              ),
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: const AdaptiveAppBar(),
        body: body,
        drawer: ListDrawer(
          selectedIndex: this.updateSelectedIndex,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'Add',
          onPressed: () {},
          tooltip: "Add Item",
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      );
    }
  }
}

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    Key? key,
    this.isDesktop = false,
  }) : super(key: key);

  final bool isDesktop;

  @override
  Size get preferredSize => isDesktop
      ? const Size.fromHeight(appBarDesktopHeight)
      : const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: !isDesktop,
        title: Text("Dashboard"),
        toolbarHeight: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ]);
  }
}

class ListDrawer extends StatefulWidget {
  Function selectedIndex;

  ListDrawer({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _ListDrawerState createState() => _ListDrawerState(
        selectedIndex: this.selectedIndex,
      );
}

class _ListDrawerState extends State<ListDrawer> {
  Function selectedIndex;
  int selectedItem = 0;

  _ListDrawerState({
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Beammart",
                style: textTheme.headline6,
              ),
              subtitle: Text(
                "Merchant Center",
                style: textTheme.bodyText2,
              ),
            ),
            const Divider(),
            ListTile(
              enabled: true,
              selected: 0 == selectedItem,
              leading: const Icon(
                Icons.dashboard,
              ),
              title: Text(
                "Dashboard",
              ),
              onTap: () {
                setState(() {
                  selectedItem = 0;
                });
                this.selectedIndex(selectedItem);
              },
            ),
            ListTile(
              enabled: true,
              selected: 1 == selectedItem,
              leading: const Icon(
                Icons.store_outlined,
              ),
              title: Text(
                "Profile",
              ),
              onTap: () {
                setState(() {
                  selectedItem = 1;
                });
                this.selectedIndex(selectedItem);
              },
            ),
            ListTile(
              enabled: true,
              selected: 2 == selectedItem,
              leading: const Icon(
                Icons.analytics_outlined,
              ),
              title: Text(
                "Analytics",
              ),
              onTap: () {
                setState(() {
                  selectedItem = 2;
                });
                this.selectedIndex(selectedItem);
              },
            ),
          ],
        ),
      ),
    );
  }
}
