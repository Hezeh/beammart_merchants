import 'package:beammart_merchants/widgets/transactions_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionsCard(),
        TransactionsCard(),
        TransactionsCard(),
      ],
    );
  }
}
