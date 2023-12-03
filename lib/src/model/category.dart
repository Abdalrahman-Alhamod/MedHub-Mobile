class Category {
  int id;
  String name;
  Category({
    required this.id,
    required this.name,
  });
  @override
  String toString() {
    return '''
    Category {
        id: $id,
        name: $name,
      }
    ''';
  }

  // JSON encoder
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Map<String, dynamic> toListJson(List<Category> categories) {
    return {'data': categories.map((product) => product.toJson()).toList()};
  }

  static List<Category> fromListJson(Map<String, dynamic> jsonData) {
    List<dynamic> jsonList = jsonData['data'];
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }

  // JSON decoder
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
