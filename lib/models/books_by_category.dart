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
  //TODO Refactor to only get books
  BooksByCategory({
    required this.bookTitle,
    required this.author,
    required this.favorite,
    required this.available,
    required this.coverImageUrl,
    required this.backCoverImageUrl,
    required this.pagesFromBook,
  });

  String bookTitle;
  String author;
  bool favorite;
  bool available;
  String coverImageUrl;
  String backCoverImageUrl;
  List<PagesFromBook> pagesFromBook;

  factory BooksByCategory.fromJson(Map<String, dynamic> json) =>
      BooksByCategory(
        bookTitle: json["bookTitle"],
        author: json["author"],
        favorite: json["favorite"],
        available: json["available"],
        coverImageUrl: json["coverImageUrl"],
        backCoverImageUrl: json["backCoverImageUrl"],
        pagesFromBook: List<PagesFromBook>.from(
            json["pagesFromBook"].map((x) => PagesFromBook.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookTitle": bookTitle,
        "author": author,
        "favorite": favorite,
        "available": available,
        "coverImageUrl": coverImageUrl,
        "backCoverImageUrl": backCoverImageUrl,
        "pagesFromBook":
            List<dynamic>.from(pagesFromBook.map((x) => x.toJson())),
      };
}

class PagesFromBook {
  PagesFromBook({
    required this.id,
    required this.pageNumber,
    this.items,
    required this.seen,
    required this.bookTitle,
  });

  String id;
  int pageNumber;
  dynamic items;
  bool seen;
  String bookTitle;

  factory PagesFromBook.fromJson(Map<String, dynamic> json) => PagesFromBook(
        id: json["id"],
        pageNumber: json["pageNumber"],
        items: json["items"],
        seen: json["seen"],
        bookTitle: json["bookTitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageNumber": pageNumber,
        "items": items,
        "seen": seen,
        "bookTitle": bookTitle,
      };
}
