import 'package:flutter/material.dart';

class TransactionDetailDivider extends StatelessWidget {
   final _color = Colors.pink;
   
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: _color,
      thickness: 2,
      indent: 10,
      endIndent: 10,
    );
  }
}
