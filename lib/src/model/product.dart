import 'package:get/get.dart';

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
  String type;
  String name;
  String scientificName;
  String brand;
  String description;
  String expirationDate;
  int price;
  int popularity;
  String image;
  int inStock;
  bool isFavourate;
  double discount;
  // ignore: unused_field
  int _quantity;
  Product({
    required this.id,
    required this.type,
    required this.name,
    required this.scientificName,
    required this.brand,
    required this.description,
    required this.expirationDate,
    required this.price,
    required this.popularity,
    required this.image,
    required this.inStock,
    required this.isFavourate,
    required this.discount,
  }) : _quantity = 0;
  factory Product.fromJson(jsonData) {
    return Product(
        id: jsonData['id'],
        type: jsonData['category'],
        name: jsonData['name'],
        scientificName: jsonData['scientificName'],
        brand: jsonData['brand'],
        description: jsonData['description'],
        expirationDate: jsonData['expirationDate'],
        price: jsonData['price'],
        popularity: jsonData['popularity'],
        image: jsonData['image'],
        inStock: jsonData['inStock'],
        isFavourate: jsonData['isFavourate'],
        discount: jsonData['discount']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = type;
    data['name'] = name;
    data['scientificName'] = scientificName;
    data['brand'] = brand;
    data['description'] = description;
    data['expirationDate'] = expirationDate;
    data['price'] = price;
    data['popularity'] = popularity;
    data['image'] = image;
    data['inStock'] = inStock;
    data['isFavourate'] = isFavourate;
    data['discount'] = discount;
    return data;
  }
}
