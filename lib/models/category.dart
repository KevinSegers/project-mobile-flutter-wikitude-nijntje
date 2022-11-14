import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

class Category {
  Category({
    required this.label,
    required this.url,
  });

  String label;
  String url;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        label: json["label"],
        url: json["url"],
      );
}
