class Statistics {
  int totalOrders;
  int refusedOrders;
  int inPreparationOrders;
  int deliveredOrders;
  String totalPayment;
  int gettingDeliveredOrders;
  int totalMedicines;
  int favouriteMedicines;
  Map<String, dynamic> categoriesPercentages;
  Statistics({
    required this.totalOrders,
    required this.refusedOrders,
    required this.inPreparationOrders,
    required this.deliveredOrders,
    required this.gettingDeliveredOrders,
    required this.totalPayment,
    required this.totalMedicines,
    required this.favouriteMedicines,
    required this.categoriesPercentages,
  });
  factory Statistics.fromJson(jsonData) {
    return Statistics(
      totalOrders: jsonData['total orders'],
      refusedOrders: jsonData['refused orders'],
      inPreparationOrders: jsonData['in preparation orders'],
      deliveredOrders: jsonData['delivered orders'],
      gettingDeliveredOrders: jsonData['getting delivered orders'],
      totalPayment: jsonData['total payment'],
      totalMedicines: jsonData['total medicines'],
      favouriteMedicines: jsonData['favourite medicines'],
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
      favouriteMedicines: $favouriteMedicines,
      categoriesPercentages: $categoriesPercentages
    }
  ''';
  }
}
