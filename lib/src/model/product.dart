import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';

abstract class ProductType {
  const ProductType._();
  // ignore: non_constant_identifier_names
  static String PainAndRelief = "PainAndRelief".tr; // مزيل للالم

  // ignore: non_constant_identifier_names
  static String ColdAndFlu = "ColdAndFlu".tr; //البرد والانفلونزا

  // ignore: non_constant_identifier_names
  static String AllergyMedications = "AllergyMedications".tr; //أدوية الحساسية

  // ignore: non_constant_identifier_names
  static String DigestiveHealth = "DigestiveHealth".tr; //صحة الجهاز الهضمي

  // ignore: non_constant_identifier_names
  static String CardiovascularMedications =
      "CardiovascularMedications".tr; //أدوية القلب والأوعية الدموية

  // ignore: non_constant_identifier_names
  static String Antibiotics = "Antibiotics".tr; //مضادات حيوية

  // ignore: non_constant_identifier_names
  static String DiabetesManagement = "DiabetesManagement".tr; //إدارة مرض السكري

  // ignore: non_constant_identifier_names
  static String DermatologicalProducts =
      "DermatologicalProducts".tr; //المنتجات الجلدية

  // ignore: non_constant_identifier_names
  static String VitaminsAndSupplements =
      "VitaminsAndSupplements".tr; //الفيتامينات والمكملات الغذائية

  // ignore: non_constant_identifier_names
  static String WomenHealth = "WomenHealth".tr; //صحة المرأة
}

class Product {
  int id;
  Category category;
  String name;
  String scientificName;
  String brand;
  String description;
  String expirationDate;
  int price;
  String image;
  int inStock;
  bool isFavorite;
  int quantity;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.scientificName,
    required this.brand,
    required this.description,
    required this.expirationDate,
    required this.price,
    required this.image,
    required this.inStock,
    required this.isFavorite,
  }) : quantity = 0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': [category.toJson()],
      'name': name,
      'scientificName': scientificName,
      'brand': brand,
      'description': description,
      'expirationDate': expirationDate,
      'price': price,
      'image': image,
      'quantity': inStock,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      category: Category.fromJson(json['category']),
      name: json['name'] as String,
      scientificName: json['scientificName'] as String,
      brand: json['brand'] as String,
      description: json['description'] as String,
      expirationDate: json['expirationDate'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
      inStock: json['quantity'] as int,
      isFavorite: json['isFavorite'] as bool,
    );
  }

  static Map<String, dynamic> toListJson(List<Product> products) {
    return {'data': products.map((product) => product.toJson()).toList()};
  }

  static List<Product> fromListJson(dynamic jsonData) {
    List<dynamic> jsonList = jsonData['data'];
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  static Map<String, dynamic> toJsonCart(List<Product> products) {
    return {
      'data': products
          .map((product) => {'id': product.id, 'quantity': product.quantity})
          .toList()
    };
  }

  @override
  String toString() {
    return '''
    Product {
      id: $id,
      category: $category,
      name: $name,
      scientificName: $scientificName,
      brand: $brand,
      description: $description,
      expirationDate: $expirationDate,
      price: $price,
      image: $image,
      inStock: $inStock,
      isFavorite: $isFavorite,
      quantity: $quantity
    }
  ''';
  }
}
