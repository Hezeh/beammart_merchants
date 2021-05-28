import 'package:beammart_merchants/widgets/wallet_widget.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text("Wallet"),
      ),
      body: WalletWidget(),
    );
  }
}