import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_products_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class AppData {
  const AppData._();

  static String dummyText =
      'Lorem Ipsum is simply dummy text of the printing and typesetting'
      ' industry. Lorem Ipsum has been the industry\'s standard dummy text'
      ' ever since the 1500s, when an unknown printer took a galley of type'
      ' and scrambled it to make a type specimen book.';
  static var format = DateFormat('yyyy/MM/dd', Intl.getCurrentLocale());
  static var date = format.format(DateTime.now()).toString();
  static void doe() {
    format.format(DateTime.now());
  }

  static List<Product> products = [
    Product(
      id: 0,
      type: ProductType.Antibiotics.toString(),
      name: "Amoxil".tr,
      scientificName: "Amoxicillin".tr,
      brand: "GlaxoSmithKline".tr,
      description: "desc".tr,
      expirationDate: date,
      price: 17500,
      popularity: 520,
      image: AppProductsImages.amoxil,
      inStock: 52,
      isFavourate: false,
      discount: 50,
    )
  ];
  static List<Category> categories = [
    Category(id: 0, name: ProductType.AllergyMedications, image: ""),
    Category(id: 0, name: ProductType.Antibiotics, image: ""),
    Category(id: 0, name: ProductType.CardiovascularMedications, image: ""),
    Category(id: 0, name: ProductType.ColdAndFlu, image: ""),
    Category(id: 0, name: ProductType.DermatologicalProducts, image: ""),
    Category(id: 0, name: ProductType.DiabetesManagement, image: ""),
    Category(id: 0, name: ProductType.DigestiveHealth, image: ""),
    Category(id: 0, name: ProductType.PainAndRelief, image: ""),
    Category(id: 0, name: ProductType.VitaminsAndSupplements, image: ""),
    Category(id: 0, name: ProductType.WomenHealth, image: ""),
  ];
}
