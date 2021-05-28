import 'package:beammart_merchants/widgets/withdraw_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar( 
        leading: Container(),
        trailing: IconButton(
          icon: Icon(
            Icons.close_outlined,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text(
          'Withdraw to Mpesa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      child: WithdrawForm(),
    );
  }
}