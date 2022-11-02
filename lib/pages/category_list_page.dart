// overzicht met photoWidget + naam van categorie + aantal books
// click action naar book_list.dart => category doorgeven

import 'package:flutter/material.dart';

import '../apis/interactive_books_api.dart';
import '../models/category.dart';
import 'books_by_category_list_page.dart';
import '../widgets/category_item.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  late List<Category> categoryList = <Category>[];

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() {
    InteractiveBooksApi.fetchCategories().then((result) {
      setState(() {
        categoryList = result;
        //debugPrint(result[0].url.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categoryItems(),
    );
  }

  GridView _categoryItems() {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 30),
        itemCount: categoryList.length,
        itemBuilder: (context, position) {
          return CategoryItem(
            title: categoryList[position].label,
            imageUrl: categoryList[position].url,
            label: categoryList[position].label,
            onTapped: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const BooksByCategoryListPage()),
              );
            },
          );
        });
  }
}
