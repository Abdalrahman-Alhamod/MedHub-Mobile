class User {
  int id;
  String name;
  String pharmacyName;
  String pharmacyLocation;
  int phoneNumber;
  String password;
  bool isAdmin;
  String image;
  User({
    required this.id,
    required this.name,
    required this.pharmacyName,
    required this.pharmacyLocation,
    required this.phoneNumber,
    required this.password,
    required this.isAdmin,
    required this.image,
  });
  factory User.fromJson(jsonData) {
    return User(
        id: jsonData['id'],
        name: jsonData['name'],
        pharmacyName: jsonData['pharmacyName'],
        pharmacyLocation: jsonData['pharmacyLocation'],
        phoneNumber: jsonData['phoneNumber'],
        password: jsonData['password'],
        isAdmin: jsonData['isAdmin'],
        image: jsonData['image']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['name'] = name;
    data['pharmacyName'] = pharmacyName;
    data['pharmacyLocation'] = pharmacyLocation;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['isAdmin'] = isAdmin;
    data['image'] = image;
    return data;
  }
}
