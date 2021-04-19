class ImpressionsAnalyticsData {
  int? searchImpressions;
  int? recommendationsImpressions;
  int? categoryImpressions;
  int? totalImpressions;

  ImpressionsAnalyticsData(
      {this.searchImpressions,
      this.recommendationsImpressions,
      this.categoryImpressions,
      this.totalImpressions});

  ImpressionsAnalyticsData.fromJson(Map<String, dynamic> json) {
    searchImpressions = json['searchImpressions'];
    recommendationsImpressions = json['recommendationsImpressions'];
    categoryImpressions = json['categoryImpressions'];
    totalImpressions = json['totalImpressions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchImpressions'] = this.searchImpressions;
    data['recommendationsImpressions'] = this.recommendationsImpressions;
    data['categoryImpressions'] = this.categoryImpressions;
    data['totalImpressions'] = this.totalImpressions;
    return data;
  }
}
