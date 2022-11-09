class Page {
  Page({
    required this.pageNumber,
    required this.itemNames,
    required this.seen,
    required this.bookTitle,
  });

  int pageNumber;
  List<String> itemNames;
  bool seen;
  String bookTitle;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        pageNumber: json["pageNumber"],
        itemNames: json["itemNames"],
        seen: json["seen"],
        bookTitle: json["bookTitle"],
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "itemNames": itemNames,
        "seen": seen,
        "bookTitle": bookTitle,
      };
}
