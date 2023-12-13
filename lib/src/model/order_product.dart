import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class OrderProduct {
  Product product;
  int orderedQuantity;
  OrderProduct({
    required this.product,
    required this.orderedQuantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      product: Product.fromJson(json),
      orderedQuantity: json['ordered_quantity'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {};
    temp.addAll(product.toJson());
    temp.addAll({
      'ordered_quantity': orderedQuantity,
    });
    return temp;
  }

  static List<OrderProduct> fromListJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['medicines'] ?? [];
    return jsonList.map((json) => OrderProduct.fromJson(json)).toList();
  }

  static Map<String, dynamic> toListJson(List<OrderProduct> products) {
    return {'medicines': products.map((product) => product.toJson()).toList()};
  }

  @override
  String toString() {
    return '''
    Order Product {
    $product 
    Ordered Quantity : $orderedQuantity
    }
    ''';
  }
}
