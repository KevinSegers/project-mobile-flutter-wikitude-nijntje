import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

// String categoryToJson(List<Category> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  // Map<String, dynamic> toJson() => {
  //       "label": label,
  //       "url": url,
  //     };
}
