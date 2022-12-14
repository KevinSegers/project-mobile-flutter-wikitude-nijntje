// overzicht met photoWidget + naam van categorie + aantal books
// click action naar book_list.dart => category doorgeven

import 'package:flutter/material.dart';

import '../apis/interactive_books_api.dart';
import '../models/category.dart';
import 'books_by_category_list_page.dart';
import '../widgets/category_item.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  late List<Category> categoryList = <Category>[];

  //Loading indicator
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() {
    isLoading = true;
    InteractiveBooksApi.fetchCategoriesWithUrls().then((result) {
      setState(() {
        categoryList = result;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color.fromARGB(255, 46, 125, 50),
                semanticsLabel: 'Loading',
              ))
            : _categoryItems());
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
            imageUrl: categoryList[position].url,
            categoryName: categoryList[position].label,
            onTapped: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => BooksByCategoryListPage(
                          category: categoryList[position].label,
                        )),
              );
            },
          );
        });
  }
}
