enum ProductType {
  painRelief, // مزيل للالم
  coldAndFlu, //البرد والانفلونزا
  allergyMedications, //أدوية الحساسية
  digestiveHealth, //صحة الجهاز الهضمي
  cardiovascularMedications, //أدوية القلب والأوعية الدموية
  antibiotics, //مضادات حيوية
  diabetesManagement, //إدارة مرض السكري
  dermatologicalProducts, //المنتجات الجلدية
  vitaminsAndSupplements, //الفيتامينات والمكملات الغذائية
  womenHealth, //صحة المرأة
}

class Product {
  int id;
  ProductType type;
  String name;
  String scientificName;
  String brand;
  String description;
  String expirationDate;
  double price;
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
