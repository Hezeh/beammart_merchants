import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const String kSilverSubscriptionId = 'subscription_silver';
const String kGoldSubscriptionId = 'subscription_gold';
const List<String> _kProductsIds = <String>[
  kSilverSubscriptionId,
  kGoldSubscriptionId,
];

class SubscriptionsProvider with ChangeNotifier {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  SubscriptionsProvider() {
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
    notifyListeners();
  }

  // Getters
  StreamSubscription<List<PurchaseDetails>> get subscription => _subscription;
  InAppPurchaseConnection get connection => _connection;
  List<String> get notFoundIds => _notFoundIds;
  List<ProductDetails> get products => _products;
  List<PurchaseDetails> get purchases => _purchases;
  bool get isAvailable => _isAvailable;
  bool get purchasePending => _purchasePending;
  bool get loading => _loading;
  String? get queryProductError => _queryProductError;

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      _isAvailable = isAvailable;
      _products = [];
      _purchases = [];
      _notFoundIds = [];
      _purchasePending = false;
      _loading = false;
      notifyListeners();
      return;
    }

    ProductDetailsResponse productDetailsResponse =
        await _connection.queryProductDetails(_kProductsIds.toSet());
    if (productDetailsResponse.error != null) {
      _queryProductError = productDetailsResponse.error!.message;
      _isAvailable = isAvailable;
      _products = productDetailsResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailsResponse.notFoundIDs;
      _purchasePending = false;
      _loading = false;
      notifyListeners();
      return;
    }

    if (productDetailsResponse.productDetails.isEmpty) {
      _queryProductError = null;
      _isAvailable = isAvailable;
      _products = productDetailsResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailsResponse.notFoundIDs;
      _purchasePending = false;
      _loading = false;
      notifyListeners();
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
    _isAvailable = isAvailable;
    _products = productDetailsResponse.productDetails;
    _purchases = verifiedPurchases;
    _notFoundIds = productDetailsResponse.notFoundIDs;
    _purchasePending = false;
    _loading = false;
    notifyListeners();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _purchasePending = true;
        notifyListeners();
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
    notifyListeners();
  }

  void _handleError(IAPError error) {
    _purchasePending = false;
    notifyListeners();
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    _purchases.add(purchaseDetails);
    _purchasePending = false;
    notifyListeners();
  }
}
