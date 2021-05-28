import 'package:beammart_merchants/utils/transaction_detail_util.dart';
import 'package:flutter/material.dart';

class TransactionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => transactionDetailUtil(context),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.deepPurple,
            ],
          ),
        ),
        child: ListTile(
          title: Text('Date: 17/11/2020'),
          subtitle: Text('Time: 17:13'),
          leading: Text('From: Hezekiah'),
          trailing: Text('Amount: Ksh.100'),
          contentPadding: EdgeInsets.all(10),
          dense: true,
          enabled: true,
        ),
      ),
    );
  }
}
