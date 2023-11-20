import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class Cart {
  int id;
  double totalPrice = 0;
  List<Product> products = <Product>[];
  Cart({required this.id});
}
