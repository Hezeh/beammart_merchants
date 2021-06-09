import 'package:flutter/material.dart';

class PaymentAmountScreen extends StatelessWidget {
  final bool? card;
  final bool? mpesa;
  final bool? airtel;
  const PaymentAmountScreen({
    Key? key,
    this.card,
    this.mpesa,
    this.airtel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amount"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("200 Tokens"),
            subtitle: Text("Amount Due: Ksh. 200"),
            trailing: ElevatedButton(
              child: Text("Buy"),
              onPressed: () {},
            ),
          ),
          ListTile(
            title: Text("500 Tokens"),
            subtitle: Text("Amount Due: Ksh. 500"),
            trailing: ElevatedButton(
              child: Text("Buy"),
              onPressed: () {},
            ),
          ),
          ListTile(
            title: Text("1000 Tokens"),
            subtitle: Text("Amount Due: Ksh. 1000"),
            trailing: ElevatedButton(
              child: Text("Buy"),
              onPressed: () {},
            ),
          ),
          ListTile(
            title: Text("2500 Tokens"),
            subtitle: Text("Amount Due: Ksh. 2500"),
            trailing: ElevatedButton(
              child: Text("Buy"),
              onPressed: () {},
            ),
          ),
          ListTile(
            title: Text("5000 Tokens"),
            subtitle: Text("Amount Due: Ksh. 5000"),
            trailing: ElevatedButton(
              child: Text("Buy"),
              onPressed: () {},
            ),
          ),
          ListTile(
            title: Text("10000 Tokens"),
            subtitle: Text("Amount Due: Ksh. 10000"),
            trailing: ElevatedButton(
              child: Text("Buy"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
