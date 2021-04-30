// import 'package:http/http.dart' as http;
// verifyPurchase() async {
//   final response = await http.get(
//     Uri(
//       scheme: 'https',
//       host: 'api.beammart.app',
//       path: 'item/impressions/analytics/$itemId',
//     ),
//   );
//   final jsonResponse = ImpressionsAnalyticsData.fromJson(json.decode(response.body));
//   if (response.statusCode == 200) {
//     return jsonResponse;
//   }
//   return ImpressionsAnalyticsData();
// }