import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class ProductController extends GetxController {
  RxList<Product> products = AppData.products.obs;

  void isFavouriate({required int productId}) {
    for (var product in products) {
      if (product.id == productId) {
        product.isFavourate = !product.isFavourate;
        update();
        break;
      }
    }
  }
}
