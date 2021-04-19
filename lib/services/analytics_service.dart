import 'dart:convert';

import 'package:beammart_merchants/models/impressions_analytics_data.dart';
import 'package:http/http.dart' as http;

Future<ImpressionsAnalyticsData> getImpressionsAnalyticsData(String? merchantId) async {
  final response = await http.get(
    Uri(
      scheme: 'https',
      host: 'api.beammart.app',
      path: 'impressions/analytics/$merchantId',
    ),
  );
  final jsonResponse = ImpressionsAnalyticsData.fromJson(json.decode(response.body));
  if (response.statusCode == 200) {
    return jsonResponse;
  }
  return ImpressionsAnalyticsData();
}