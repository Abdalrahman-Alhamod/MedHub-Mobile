import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/order_product.dart';

class OrderStatus {
  OrderStatus();
  // ignore: non_constant_identifier_names
  String Preparing = 'preparing'.tr;

  // ignore: non_constant_identifier_names
  String Delivering = 'delivering'.tr;

  // ignore: non_constant_identifier_names
  String Recieved = 'recieved'.tr;

  // ignore: non_constant_identifier_names
  String Refused = 'refused'.tr;
}

class Order {
  int id;
  int bill;
  String status;
  bool isPayed;
  String date;
  List<OrderProduct> orderedProducts;

  Order({
    required this.id,
    required this.bill,
    required this.status,
    required this.isPayed,
    required this.date,
    this.orderedProducts = const [],
  });

  factory Order.fromJson(jsonData) {
    return Order(
      id: jsonData['id'] as int,
      bill: jsonData['bill'] as int,
      status: _getStatusFromJson(jsonData['status']),
      isPayed: jsonData['payment_status'] == 1,
      date: jsonData['ordered_at'],
      orderedProducts: OrderProduct.fromListJson(jsonData),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bill'] = bill;
    data['status'] = status;
    data['payment_status'] = isPayed;
    data['ordered_at'] = date;
    data['medicines'] = OrderProduct.toListJson(orderedProducts);
    return data;
  }

  static List<Order> fromListJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['data'];
    return jsonList.map((json) => Order.fromJson(json)).toList();
  }

  static Map<String, dynamic> toListJson(List<Order> orders) {
    return {'data': orders.map((order) => order.toJson()).toList()};
  }

  static String _getStatusFromJson(dynamic status) {
    OrderStatus orderStatus = OrderStatus();
    if (status == 'in preparation') {
      return orderStatus.Preparing;
    } else if (status == 'getting delivered') {
      return orderStatus.Delivering;
    } else if (status == 'delivered') {
      return orderStatus.Recieved;
    } else if (status == 'refused') {
      return orderStatus.Refused;
    } else {
      logger.e("Order Json Status is not recognised");
      throw Exception("Order Json Status is not recognised");
    }
  }

  @override
  String toString() {
    return '''
      Order {
      Order ID: $id
      Bill: $bill
      Status: $status
      Is Payed: $isPayed
      Date: $date
      Ordered Products: 
      $orderedProducts
    }
    ''';
  }
}
