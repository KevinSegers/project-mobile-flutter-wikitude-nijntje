import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/widgets/books_list.dart';

class BooksByCategoryListPage extends StatelessWidget {
  const BooksByCategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR kinder boeken"), //TODO vervangen door categorie
        centerTitle: true,
      ),
      body: const BooksList(),
    );
  }
}
