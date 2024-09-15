// models/category.dart
class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  // Assuming the response data contains fields 'id' and 'name'
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
