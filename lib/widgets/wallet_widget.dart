import 'package:beammart_merchants/utils/all_transactions_util.dart';
import 'package:beammart_merchants/utils/withdraw_util.dart';
import 'package:beammart_merchants/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WalletWidget extends StatefulWidget {
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  bool showAmount = false;
  
  void _showAmountFunc() {
    setState(() {
      showAmount = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(15.0),
          child: CircularPercentIndicator(
            radius: 250.0,
            lineWidth: 10,
            percent: 1,
            animation: true,
            animationDuration: 1000,
            header: Text(
              'Account Balance',
              style: GoogleFonts.yellowtail(
                  fontSize: 30.0,
                  color: Colors.pink,
                  // decoration: TextDecoration.underline,
                  letterSpacing: 2.0,
                  decorationColor: Colors.purple,
                  decorationThickness: 10),
            ),
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Colors.pink,
                Colors.purple,
              ],
            ),
            center: showAmount
                ? InkWell(
                    onTap: () => allTransactionsUtil(context),
                    child: Text(
                      "Ksh. 100.00",
                      style: GoogleFonts.yellowtail(
                        fontSize: 30.0,
                        color: Colors.pink,
                      ),
                    ),
                  )
                : Text(''),
            onAnimationEnd: () => _showAmountFunc(),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 10,
          ),
          child: ElevatedButton(
            onPressed: () => withdrawUtil(context),
            child: Text('Withdraw'),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
        ),
        Center(
          child: Text(
            'Recent Transactions',
            style: GoogleFonts.gelasio(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RecentTransactions(),
        Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
            child: Text(
              'View All Transactions',
            ),
            onPressed: () => allTransactionsUtil(context),
          ),
        )
      ],
    );
  }
}
