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

  static List<Map<String, dynamic>> toJsonList(List<Category> categories) {
    return categories.map((category) => category.toJson()).toList();
  }

  static List<Category> fromJsonList(List<Map<String, dynamic>> jsonList) {
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
