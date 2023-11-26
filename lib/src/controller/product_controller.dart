import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class ProductController extends GetxController {
  final products = AppData.products.obs;
  var loading = false.obs;
  
  void isFavouriate({required int productId}) {
    for (var product in products) {
      if (product.id == productId) {
        product.isFavourate = !product.isFavourate;
        break;
      }
    }
  }

  Product? getProductById({required int productId}) {
    for (var product in products) {
      if (product.id == productId) {
        return product;
      }
    }
    return null;
  }
}
