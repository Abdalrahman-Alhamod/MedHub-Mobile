import 'package:intl/intl.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_products_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class AppData {
  const AppData._();

  static String dummyText =
      'Lorem Ipsum is simply dummy text of the printing and typesetting'
      ' industry. Lorem Ipsum has been the industry\'s standard dummy text'
      ' ever since the 1500s, when an unknown printer took a galley of type'
      ' and scrambled it to make a type specimen book.';
  static var format = DateFormat.yMd(Intl.getCurrentLocale());
  static var date = format.format(DateTime.now()).toString();
  static void doe() {
    format.format(DateTime.now());
  }

  static List<Product> products = [
    Product(
      id: 0,
      type: ProductType.antibiotics,
      name: "Amoxil",
      scientificName: "Amoxicillin",
      brand: "GlaxoSmithKline",
      description:
          "Amoxil is a penicillin antibiotic, which is given to treat the infections caused by bacteria",
      expirationDate: date,
      price: 15.99,
      popularity: 520,
      image: AppProductsImages.amoxil,
      inStock: 52,
      isFavourate: false,
      discount: 50,
    )
  ];
}
