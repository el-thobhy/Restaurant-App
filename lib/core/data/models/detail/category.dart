

class Category {
  final String name;

  const Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json['name']);
}