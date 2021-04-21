import 'dart:async';
import 'dart:io';

import 'package:beammart_merchants/models/impressions_analytics_data.dart';
import 'package:beammart_merchants/services/analytics_service.dart';
import 'package:beammart_merchants/utils/consumable_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const bool _kAutoConsume = true;

const String _kConsumableId = 'consumable';
const String _kUpgradeId = 'upgrade';
const String _kSilverSubscriptionId = 'subscription_silver';
const String _kGoldSubscriptionId = 'subscription_gold';
const List<String> _kProductsIds = <String>[
  _kConsumableId,
  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,
];

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      print(error);
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailsResponse =
        await _connection.queryProductDetails(_kProductsIds.toSet());
    if (productDetailsResponse.error != null) {
      setState(() {
        _queryProductError = productDetailsResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailsResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailsResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailsResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailsResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailsResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
        await _connection.queryPastPurchases();
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailsResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailsResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchasedUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  void _showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return Card(
        child: ListTile(
          title: const Text('Trying to connect...'),
        ),
      );
    }
    final Widget storeHeader = ListTile(
      leading: Icon(
        _isAvailable ? Icons.check : Icons.block,
        color: _isAvailable ? Colors.green : ThemeData.light().errorColor,
      ),
      title: Text(
          'The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll([
        Divider(),
        ListTile(
          title: Text(
            'Not connected',
            style: TextStyle(color: ThemeData.light().errorColor),
          ),
          subtitle: const Text(
            'Unable to connect to the payments processor. Has this app been configured correctly?',
          ),
        ),
      ]);
    }
    return Card(
      child: Column(
        children: children,
      ),
    );
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(
        child: (ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Fetching products...'),
        )),
      );
    }
    if (!_isAvailable) {
      return Card();
    }
    final ListTile productHeader = ListTile(
      title: Text('Products for Sale'),
    );
    List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
        title: Text(
          '[${_notFoundIds.join(", ")}] not found',
          style: TextStyle(color: ThemeData.light().errorColor),
        ),
        subtitle: Text('This app needs special configuration to run.'),
      ));
    }

    // This loading previous purchases code is just a demo. Please do not this
    // as it is. In your app you should always verify the purchase data using the
    // `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map((ProductDetails productDetails) {
      PurchaseDetails? previousPurchase = purchases[productDetails.id];
      return ListTile(
        title: Text(
          productDetails.title,
        ),
        subtitle: Text(
          productDetails.description,
        ),
        trailing: previousPurchase != null
            ? Icon(Icons.check)
            : TextButton(
                onPressed: () {
                  // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                  // verify the latest status of you your subscription by using server side receipt validation
                  // and update the UI accordingly. The subscription purchase status shown
                  // inside the app may not be accurate.
                  final oldSubscription =
                      _getOldSubscription(productDetails, purchases);
                  PurchaseParam purchaseParam = PurchaseParam(
                      productDetails: productDetails,
                      applicationUserName: null,
                      changeSubscriptionParam:
                          Platform.isAndroid && oldSubscription != null
                              ? ChangeSubscriptionParam(
                                  oldPurchaseDetails: oldSubscription,
                                  prorationMode:
                                      ProrationMode.immediateWithTimeProration)
                              : null);
                  if (productDetails.id == _kConsumableId) {
                    _connection.buyConsumable(
                        purchaseParam: purchaseParam,
                        autoConsume: _kAutoConsume || Platform.isIOS);
                  } else {
                    _connection.buyNonConsumable(purchaseParam: purchaseParam);
                  }
                },
                child: Text(productDetails.price),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  primary: Colors.white,
                ),
              ),
      );
    }));
    return Card(
        child:
            Column(children: <Widget>[productHeader, Divider()] + productList));
  }

  Card _buildConsumableBox() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching consumables...'))));
    }
    if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
      return Card();
    }
    final ListTile consumableHeader =
        ListTile(title: Text('Purchased consumables'));
    final List<Widget> tokens = _consumables.map((String id) {
      return GridTile(
        child: IconButton(
          icon: Icon(
            Icons.stars,
            size: 42.0,
            color: Colors.orange,
          ),
          splashColor: Colors.yellowAccent,
          onPressed: () => consume(id),
        ),
      );
    }).toList();
    return Card(
        child: Column(children: <Widget>[
      consumableHeader,
      Divider(),
      GridView.count(
        crossAxisCount: 5,
        children: tokens,
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
      )
    ]));
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void _handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            await InAppPurchaseConnection.instance
                .consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  PurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    PurchaseDetails? oldSubscription;
    if (productDetails.id == _kSilverSubscriptionId &&
        purchases[_kGoldSubscriptionId] != null) {
      oldSubscription = purchases[_kGoldSubscriptionId];
    } else if (productDetails.id == _kGoldSubscriptionId &&
        purchases[_kSilverSubscriptionId] != null) {
      oldSubscription = purchases[_kSilverSubscriptionId];
    }
    return oldSubscription;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            _buildConnectionCheckTile(),
            _buildProductList(),
            _buildConsumableBox(),
          ],
        ),
      );
    } else {
      stack.add(
        Center(
          child: Text(_queryProductError!),
        ),
      );
    }
    if (_purchasePending) {
      stack.add(Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
      ),
      body: Stack(
        children: stack,
      ),
      // body: ListView(
      //   children: [
      //     // Total Impressions
      //     Container(
      //       child: Center(
      //         child: Text(
      //           'Impressions',
      //           style: GoogleFonts.roboto(
      //               fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //       ),
      //     ),
      //     FutureBuilder(
      //       future: getImpressionsAnalyticsData(currentUser!.uid),
      //       builder: (BuildContext context,
      //           AsyncSnapshot<ImpressionsAnalyticsData> snapshot) {
      //         if (snapshot.hasData) {
      //           return Container(
      //             // height: 250,
      //             child: Column(
      //               children: [
      //                 ListTile(
      //                   title: Text('Total Impressions'),
      //                   trailing: Text(
      //                     "${snapshot.data!.totalImpressions}",
      //                   ),
      //                 ),
      //                 ListTile(
      //                   title: Text('Search Impressions'),
      //                   trailing: Text(
      //                     "${snapshot.data!.searchImpressions}",
      //                   ),
      //                 ),
      //                 ListTile(
      //                   title: Text('Recommendations Impressions'),
      //                   trailing: Text(
      //                     "${snapshot.data!.recommendationsImpressions}",
      //                   ),
      //                 ),
      //                 ListTile(
      //                   title: Text('Category Impressions'),
      //                   trailing: Text(
      //                     "${snapshot.data!.categoryImpressions}",
      //                   ),
      //                 )
      //               ],
      //             ),
      //           );
      //         }
      //         return Container(
      //           height: 250,
      //           // margin: EdgeInsets.all(20),
      //           child: Center(
      //             child: CircularProgressIndicator(),
      //           ),
      //         );
      //       },
      //     ),
      //     // Total Impressions last 30 days
      //     // Total Impression last 7 days
      //     // Profile Views
      //     // Call Button Clicks
      //     // Product Clicks
      //     // Product Impressions
      //     // Search Results Impressions
      //     // Search Results Clicks
      //     // Search Results CTR
      //     // Most popular search queries 7 days
      //     // Most popular search queries 30 days
      //   ],
      // ),
    );
  }
}
