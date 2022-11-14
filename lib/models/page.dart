class Page {
  Page({
    required this.pageNumber,
    required this.items,
    required this.seen,
    required this.bookTitle,
  });

  int pageNumber;
  List<String> items;
  bool seen;
  String bookTitle;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        pageNumber: json["pageNumber"],
        items: List<String>.from(json["items"].map((x) => x)),
        seen: json["seen"],
        bookTitle: json["bookTitle"],
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "items": List<dynamic>.from(items.map((x) => x)),
        "seen": seen,
        "bookTitle": bookTitle,
      };
}
