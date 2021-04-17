import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
      ),
      body: ListView(  
        children: [
          Center( child: ElevatedButton(
            child: Text('Coming Soon'),
            onPressed: () {},
          ),)
          // Total Impressions
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
    );
  }
}