import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/widgets/books_list.dart';

import '../apis/interactive_books_api.dart';
import '../models/books_by_category.dart';

class BooksByCategoryListPage extends StatefulWidget {
  final String category;
  const BooksByCategoryListPage({Key? key, required this.category})
      : super(key: key);

  @override
  State<BooksByCategoryListPage> createState() =>
      _BooksByCategoryListPageState();
}

class _BooksByCategoryListPageState extends State<BooksByCategoryListPage> {
  late List<BooksByCategory> bookList = <BooksByCategory>[];

  @override
  Widget build(BuildContext context) {
    String category = widget.category;
    return Scaffold(
      appBar: AppBar(
        title: Text("AR boeken van $category"),
        centerTitle: true,
      ),
      body: BooksList(
        category: category,
      ),
    );
  }
}
