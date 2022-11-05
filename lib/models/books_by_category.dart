// To parse this JSON data, do
//
//     final booksByCategory = booksByCategoryFromJson(jsonString);

import 'dart:convert';

List<BooksByCategory> booksByCategoryFromJson(String str) =>
    List<BooksByCategory>.from(
        json.decode(str).map((x) => BooksByCategory.fromJson(x)));

String booksByCategoryToJson(List<BooksByCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BooksByCategory {
  BooksByCategory({
    required this.title,
    required this.author,
    required this.favorite,
    required this.available,
    required this.coverImageUrl,
    required this.backCoverImageUrl,
  });

  String title;
  String author;
  bool favorite;
  bool available;
  String coverImageUrl;
  String backCoverImageUrl;

  factory BooksByCategory.fromJson(Map<String, dynamic> json) =>
      BooksByCategory(
        title: json["title"],
        author: json["author"],
        favorite: json["favorite"],
        available: json["available"],
        coverImageUrl: json["coverImageUrl"],
        backCoverImageUrl: json["backCoverImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "favorite": favorite,
        "available": available,
        "coverImageUrl": coverImageUrl,
        "backCoverImageUrl": backCoverImageUrl,
      };
}
