import 'package:beammart_merchants/utils/transaction_detail_util.dart';
import 'package:beammart_merchants/widgets/transactions_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Container(),
        middle: Text('All Transactions', style: TextStyle( color: Colors.white),),
        trailing: IconButton(
          icon: Icon(
            Icons.close_outlined,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
      ),
     child: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => transactionDetailUtil(context),
            child: TransactionsCard(),
          );
        },
      ),
    );
  }
}
