class User {
  int id;
  String name;
  String pharmacyName;
  String? pharmacyLocation;
  int phoneNumber;
  String? password;
  bool? isAdmin;
  String image;
  static String? token =
      "5BBzrJ2GCfeBB3RIHYBL2mEO3epUXQ3NfRVGoyX1hnHvV5RzhUAwErrkzUl5";
  static String? fCMToken;
  User({
    required this.id,
    required this.name,
    required this.pharmacyName,
    required this.pharmacyLocation,
    required this.phoneNumber,
    this.password,
    this.isAdmin,
    required this.image,
  });
  factory User.fromJson(jsonData) {
    return User(
        id: jsonData['id'] as int,
        name: jsonData['name'] as String,
        pharmacyName: jsonData['pharmacyName'] as String,
        pharmacyLocation: jsonData['pharmacyLocation'],
        phoneNumber: int.parse(jsonData['phoneNumber']),
        image: jsonData['image']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pharmacyName'] = pharmacyName;
    data['pharmacyLocation'] = pharmacyLocation ?? "";
    data['phoneNumber'] = phoneNumber;
    data['password'] = password ?? "";
    data['isAdmin'] = isAdmin ?? false;
    data['image'] = image;
    return data;
  }

  @override
  String toString() {
    return '''
    User {
      id: $id,
      name: $name,
      pharmacyName: $pharmacyName,
      pharmacyLocation: $pharmacyLocation,
      phoneNumber: $phoneNumber,
      password: $password,
      isAdmin: $isAdmin,
      image: $image
    }
  ''';
  }
}
