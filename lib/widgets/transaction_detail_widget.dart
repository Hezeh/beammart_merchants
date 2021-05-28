import 'package:beammart_merchants/widgets/transaction_divider_widget.dart';
import 'package:flutter/material.dart';

class TransactionDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Text(
            'Transaction Detail',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.close_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        TransactionDetailDivider(),
        Container(
          child: ListTile(
            leading: Text('Type:'),
            trailing: Text('Received'),
          ),
        ),
        TransactionDetailDivider(),
        Container(
          child: ListTile(
            leading: Text('Day:'),
            trailing: Text('Tuesday'),
          ),
        ),
        TransactionDetailDivider(),
        Container(
          child: ListTile(
            leading: Text('Time:'),
            trailing: Text('11:38:55'),
          ),
        ),
        TransactionDetailDivider(),
        Container(
          child: ListTile(
            leading: Text('Amount'),
            trailing: Text('Ksh. 100.00'),
          ),
        ),
        TransactionDetailDivider(),
      ],
    );
  }
}
