class StatisticsData {
  int totalOrders;
  int inPreparationOrders;
  int deliveredOrders;
  int gettingDeliveredOrders;
  int refusedOrders;
  int totalPayment;
  int totalMedicines;
  int favoriteMedicines;
  Map<String, dynamic> categoriesPercentages;
  Map<String, dynamic>? monthChartsData;
  StatisticsData({
    required this.totalOrders,
    required this.refusedOrders,
    required this.inPreparationOrders,
    required this.deliveredOrders,
    required this.gettingDeliveredOrders,
    required this.totalPayment,
    required this.totalMedicines,
    required this.favoriteMedicines,
    required this.categoriesPercentages,
  });
  factory StatisticsData.fromJson(jsonData) {
    return StatisticsData(
      totalOrders: jsonData['total orders'],
      refusedOrders: jsonData['refused orders'],
      inPreparationOrders: jsonData['in preparation orders'],
      deliveredOrders: jsonData['delivered orders'],
      gettingDeliveredOrders: jsonData['getting delivered orders'],
      totalPayment: jsonData['total payment'],
      totalMedicines: jsonData['total medicines'],
      favoriteMedicines: jsonData['favorite medicines'],
      categoriesPercentages: jsonData['categories percentages'],
    );
  }
  @override
  String toString() {
    return '''
    Statistics {
      totalOrders: $totalOrders,
      refusedOrders: $refusedOrders,
      inPreparationOrders: $inPreparationOrders,
      deliveredOrders: $deliveredOrders,
      gettingDeliveredOrders: $gettingDeliveredOrders,
      totalPayment: $totalPayment,
      totalMedicines: $totalMedicines,
      favoriteMedicines: $favoriteMedicines,
      categoriesPercentages: $categoriesPercentages
    }
  ''';
  }
}
