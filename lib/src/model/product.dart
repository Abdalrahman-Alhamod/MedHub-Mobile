import 'package:flutter/foundation.dart';

class Product {
  int id;
  Category category;
  String name;
  String scientificName;
  String brand;
  String description;
  DateTime expirationDate;
  double price;
  String popularity;
  String image;
  int inStock;
  bool isFavourate;
  // ignore: unused_field
  int _quantity;
  Product({
    required this.id,
    required this.category,
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
  }) : _quantity = 0;
  factory Product.fromJson(jsonData) {
    return Product(
      id: jsonData['id'],
      category: jsonData['category'],
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
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
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
    return data;
  }
}
