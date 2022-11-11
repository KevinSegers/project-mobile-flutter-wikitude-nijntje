import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/widgets/books_list.dart';

class BooksByCategoryListPage extends StatefulWidget {
  final String category;
  const BooksByCategoryListPage({Key? key, required this.category})
      : super(key: key);

  @override
  State<BooksByCategoryListPage> createState() =>
      _BooksByCategoryListPageState();
}

class _BooksByCategoryListPageState extends State<BooksByCategoryListPage> {
  @override
  Widget build(BuildContext context) {
    String category = widget.category;
    return Scaffold(
      appBar: AppBar(
        title: Text("Boeken van $category"),
        centerTitle: true,
      ),
      body: BooksList(
        category: category,
      ),
    );
  }
}
