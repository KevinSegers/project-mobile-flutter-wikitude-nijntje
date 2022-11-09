// To parse this JSON data, do
//
//     final booksByCategory = booksByCategoryFromJson(jsonString);

import 'dart:convert';

List<Book> booksByCategoryFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String booksByCategoryToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
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

  factory Book.fromJson(Map<String, dynamic> json) => Book(
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
