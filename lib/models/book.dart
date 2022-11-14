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
    required this.id,
    required this.title,
    required this.author,
    required this.favorite,
    required this.available,
    required this.coverImageUrl,
    required this.backCoverImageUrl,
  });

  int id;
  String title;
  String author;
  bool favorite;
  bool available;
  String coverImageUrl;
  String backCoverImageUrl;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        favorite: json["favorite"],
        available: json["available"],
        coverImageUrl: json["coverImageUrl"],
        backCoverImageUrl: json["backCoverImageUrl"],
      );

  set percentageRead(void percentageRead) {}

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "favorite": favorite,
        "available": available,
        "coverImageUrl": coverImageUrl,
        "backCoverImageUrl": backCoverImageUrl,
      };
}
