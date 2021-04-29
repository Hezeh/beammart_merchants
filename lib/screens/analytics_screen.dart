import 'package:beammart_merchants/models/click_analytics.dart';
import 'package:beammart_merchants/models/impressions_analytics_data.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:beammart_merchants/screens/payments_subscriptions_screen.dart';
import 'package:beammart_merchants/services/analytics_service.dart';
import 'package:beammart_merchants/widgets/indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
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
    List<PieChartSectionData>? showingSections({
      double? total,
      double? search,
      double? recs,
      double? category,
      double? profile,
    }) {
      List<PieChartSectionData> _chart = [];
      final double fontSize = 16;
      final double radius = 50;
      if (search != 0.0 && search != null) {
        _chart.add(
          PieChartSectionData(
            color: const Color(0xff0293ee),
            value: search,
            title: "${((search / total!) * 100).toStringAsFixed(0)}%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          ),
        );
      }
      if (category != 0.0 && category != null) {
        _chart.add(
          PieChartSectionData(
            color: const Color(0xff845bef),
            value: category,
            title: "${((category / total!) * 100).toStringAsFixed(0)}%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          ),
        );
      }
      if (recs != 0.0 && recs != null) {
        _chart.add(
          PieChartSectionData(
            color: const Color(0xfff8b250),
            value: recs,
            title: "${((recs / total!) * 100).toStringAsFixed(0)}%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          ),
        );
      }
      if (profile != 0.0 && profile != null) {
        _chart.add(
          PieChartSectionData(
            color: const Color(0xff13d38e),
            value: profile,
            title: "${((profile / total!) * 100).toStringAsFixed(0)}%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          ),
        );
      }
      return _chart;
    }

    Widget _buildImpressionsAnalytics(String _userId) {
      return Card(
        child: Container(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
                    List<Widget> indicators = [];
                    if (snapshot.data!.searchImpressions!.ceilToDouble() !=
                        0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xff0293ee),
                          text: 'Search',
                          isSquare: true,
                        ),
                      );
                    }
                    if (snapshot.data!.categoryImpressions!.ceilToDouble() !=
                        0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xff845bef),
                          text: 'Category',
                          isSquare: true,
                        ),
                      );
                    }
                    if (snapshot.data!.recommendationsImpressions!
                            .ceilToDouble() !=
                        0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xfff8b250),
                          text: 'Recs',
                          isSquare: true,
                        ),
                      );
                    }
                    if (snapshot.data!.profileImpressions!.ceilToDouble() !=
                        0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xff13d38e),
                          text: 'Profile',
                          isSquare: true,
                        ),
                      );
                    }
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
                          ),
                          ListTile(
                            title: Text('Profile Impressions'),
                            trailing: Text(
                              "${snapshot.data!.profileImpressions}",
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 1.3,
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: (snapshot.data!.totalImpressions!
                                                  .ceilToDouble() !=
                                              0.0)
                                          ? PieChart(
                                              PieChartData(
                                                pieTouchData: PieTouchData(
                                                    enabled: false),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 40,
                                                sections: showingSections(
                                                  total: snapshot
                                                      .data!.totalImpressions!
                                                      .ceilToDouble(),
                                                  category: snapshot.data!
                                                      .categoryImpressions!
                                                      .ceilToDouble(),
                                                  recs: snapshot.data!
                                                      .recommendationsImpressions!
                                                      .ceilToDouble(),
                                                  search: snapshot
                                                      .data!.searchImpressions!
                                                      .ceilToDouble(),
                                                  profile: snapshot
                                                      .data!.profileImpressions!
                                                      .ceilToDouble(),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Center(
                                                child: Text(
                                                  'No Data',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: indicators,
                                  ),
                                  const SizedBox(
                                    width: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
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

    Widget _buildClickAnalytics(String _userId) {
      return Card(
        child: Container(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              // Total Clicks
              Container(
                child: Center(
                  child: Text(
                    'Clicks',
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FutureBuilder(
                future: getClicksAnalyticsData(_userId),
                builder: (BuildContext context,
                    AsyncSnapshot<ClickAnalytics> snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> indicators = [];

                    if (snapshot.data!.searchClicks!.ceilToDouble() != 0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xff0293ee),
                          text: 'Search',
                          isSquare: true,
                        ),
                      );
                    }
                    if (snapshot.data!.categoryClicks!.ceilToDouble() != 0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xff845bef),
                          text: 'Category',
                          isSquare: true,
                        ),
                      );
                    }
                    if (snapshot.data!.recommendationsClicks!.ceilToDouble() !=
                        0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xfff8b250),
                          text: 'Recs',
                          isSquare: true,
                        ),
                      );
                    }
                    if (snapshot.data!.profileClicks!.ceilToDouble() != 0.0) {
                      indicators.add(
                        Indicator(
                          color: Color(0xff13d38e),
                          text: 'Profile',
                          isSquare: true,
                        ),
                      );
                    }
                    return Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Total Clicks'),
                            trailing: Text(
                              "${snapshot.data!.totalClicks}",
                            ),
                          ),
                          ListTile(
                            title: Text('Search Page Clicks'),
                            trailing: Text(
                              "${snapshot.data!.searchClicks}",
                            ),
                          ),
                          ListTile(
                            title: Text('Recommendations Page Clicks'),
                            trailing: Text(
                              "${snapshot.data!.recommendationsClicks}",
                            ),
                          ),
                          ListTile(
                            title: Text('Category Page Clicks'),
                            trailing: Text(
                              "${snapshot.data!.categoryClicks}",
                            ),
                          ),
                          ListTile(
                            title: Text('Profile Page Clicks'),
                            trailing: Text(
                              "${snapshot.data!.profileClicks}",
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 1.3,
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: (snapshot.data!.totalClicks!
                                                  .ceilToDouble() !=
                                              0.0)
                                          ? PieChart(
                                              PieChartData(
                                                pieTouchData: PieTouchData(
                                                  enabled: false,
                                                ),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 40,
                                                sections: showingSections(
                                                  total: snapshot
                                                      .data!.totalClicks!
                                                      .ceilToDouble(),
                                                  category: snapshot
                                                      .data!.categoryClicks!
                                                      .ceilToDouble(),
                                                  recs: snapshot.data!
                                                      .recommendationsClicks!
                                                      .ceilToDouble(),
                                                  search: snapshot
                                                      .data!.searchClicks!
                                                      .ceilToDouble(),
                                                  profile: snapshot
                                                      .data!.profileClicks!
                                                      .ceilToDouble(),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Center(
                                                child: Text(
                                                  'No Data',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: indicators,
                                  ),
                                  const SizedBox(
                                    width: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
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
            _buildImpressionsAnalytics(currentUser!.uid),
            _buildClickAnalytics(currentUser.uid)
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
