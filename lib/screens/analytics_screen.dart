import 'package:beammart_merchants/models/impressions_analytics_data.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/screens/payments_subscriptions_screen.dart';
import 'package:beammart_merchants/services/analytics_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final subsProvider = Provider.of<SubscriptionsProvider>(context);

    Widget _buildAnalytics(String _userId) {
      return Card(
        child: Container(
          height: 250,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Total Impressions
              Container(
                child: Center(
                  child: Text(
                    'Impressions',
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FutureBuilder(
                future: getImpressionsAnalyticsData(_userId),
                builder: (BuildContext context,
                    AsyncSnapshot<ImpressionsAnalyticsData> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      // height: 250,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Total Impressions'),
                            trailing: Text(
                              "${snapshot.data!.totalImpressions}",
                            ),
                          ),
                          ListTile(
                            title: Text('Search Impressions'),
                            trailing: Text(
                              "${snapshot.data!.searchImpressions}",
                            ),
                          ),
                          ListTile(
                            title: Text('Recommendations Impressions'),
                            trailing: Text(
                              "${snapshot.data!.recommendationsImpressions}",
                            ),
                          ),
                          ListTile(
                            title: Text('Category Impressions'),
                            trailing: Text(
                              "${snapshot.data!.categoryImpressions}",
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container(
                    height: 250,
                    // margin: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              // Total Impressions last 30 days
              // Total Impression last 7 days
              // Profile Views
              // Call Button Clicks
              // Product Clicks
              // Product Impressions
              // Search Results Impressions
              // Search Results Clicks
              // Search Results CTR
              // Most popular search queries 7 days
              // Most popular search queries 30 days
            ],
          ),
        ),
      );
    }

    List<Widget> stack = [];
    if (subsProvider.queryProductError == null) {
      stack.add(
        ListView(
          children: [
            _buildAnalytics(currentUser!.uid),
          ],
        ),
      );
    } else {
      stack.add(
        Center(
          child: Text(subsProvider.queryProductError!),
        ),
      );
    }
    if (subsProvider.purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(
                dismissible: false,
                color: Colors.grey,
              ),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }
    if (subsProvider.purchases.isEmpty) {
      return PaymentsSubscriptionsScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
      ),
      body: Stack(
        children: stack,
      ),
    );
  }
}
