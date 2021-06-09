import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/screens/payment_methods_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

class TokensScreen extends StatelessWidget {
  final double iconSize = 30;
  final Color iconColor = Colors.white;
  final TextStyle _textStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    final _subsProvider = Provider.of<SubscriptionsProvider>(context);
    if (_subsProvider.isAvailable) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrange,
                    Colors.red,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Container(
                    child: Center(
                      child: Text("Buy using your Google Play Account"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Center(
                      child: Text("Or"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        elevation: 30,
                      ),
                      child: Text('Add Payment Method'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PaymentMethodsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  // 200 tokens,
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.amber,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Icon(
                          Icons.toll_outlined,
                          size: iconSize,
                          color: iconColor,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Tokens: 200',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              '${_subsProvider.products.firstWhere(
                                    (element) => element.id == k200TokensId,
                                  ).price.toString()}',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text('Buy Now'),
                            onPressed: () {
                              _subsProvider.connection.buyConsumable(
                                purchaseParam: PurchaseParam(
                                  productDetails:
                                      _subsProvider.products.firstWhere(
                                    (element) => element.id == k200TokensId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 500 tokens,
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.blue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Icon(
                          Icons.toll_outlined,
                          size: iconSize,
                          color: iconColor,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Tokens: 500',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              '${_subsProvider.products.firstWhere(
                                    (element) => element.id == k500TokensId,
                                  ).price.toString()}',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text('Buy Now'),
                            onPressed: () {
                              _subsProvider.connection.buyConsumable(
                                purchaseParam: PurchaseParam(
                                  productDetails:
                                      _subsProvider.products.firstWhere(
                                    (element) => element.id == k500TokensId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 1000 tokens,
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo,
                          Colors.amber,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Icon(
                          Icons.toll_outlined,
                          size: iconSize,
                          color: iconColor,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Tokens: 1,000',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              '${_subsProvider.products.firstWhere(
                                    (element) => element.id == k1000TokensId,
                                  ).price.toString()}',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text('Buy Now'),
                            onPressed: () {
                              _subsProvider.connection.buyConsumable(
                                purchaseParam: PurchaseParam(
                                  productDetails:
                                      _subsProvider.products.firstWhere(
                                    (element) => element.id == k1000TokensId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2000 tokens,
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.blue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Icon(
                          Icons.toll_outlined,
                          size: iconSize,
                          color: iconColor,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Tokens: 2,500',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              '${_subsProvider.products.firstWhere(
                                    (element) => element.id == k2500TokensId,
                                  ).price.toString()}',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text('Buy Now'),
                            onPressed: () {
                              _subsProvider.connection.buyConsumable(
                                purchaseParam: PurchaseParam(
                                  productDetails:
                                      _subsProvider.products.firstWhere(
                                    (element) => element.id == k2500TokensId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 5000 tokens,
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.blue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Icon(
                          Icons.toll_outlined,
                          size: iconSize,
                          color: iconColor,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Tokens: 5,000',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              '${_subsProvider.products.firstWhere(
                                    (element) => element.id == k5000TokensId,
                                  ).price.toString()}',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text('Buy Now'),
                            onPressed: () {
                              _subsProvider.connection.buyConsumable(
                                purchaseParam: PurchaseParam(
                                  productDetails:
                                      _subsProvider.products.firstWhere(
                                    (element) => element.id == k5000TokensId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 10,000 Tokens
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.blue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Icon(
                          Icons.toll_outlined,
                          size: iconSize,
                          color: iconColor,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Tokens: 10,000',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              '${_subsProvider.products.firstWhere(
                                    (element) => element.id == k10000TokensId,
                                  ).price.toString()}',
                              style: _textStyle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text('Buy Now'),
                            onPressed: () {
                              _subsProvider.connection.buyConsumable(
                                purchaseParam: PurchaseParam(
                                  productDetails:
                                      _subsProvider.products.firstWhere(
                                    (element) => element.id == k10000TokensId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
