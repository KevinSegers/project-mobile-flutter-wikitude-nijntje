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
  List<Category> categoryList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() {
    InteractiveBooksApi.fetchCategories().then((result) {
      setState(() {
        categoryList = result;
        count = categoryList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 30,
        crossAxisCount: 2,
        children: <Widget>[
          CategoryItem(
            title: "Category Nijntje",
            imageUrl: "https://i.postimg.cc/3wpjLy5b/nijntje-cover.jpg",
            abstract: "Nijntje",
            onTapped: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const BooksByCategoryListPage()),
              );
            },
          ),
          CategoryItem(
            title: "Category Bumba",
            imageUrl: "https://i.postimg.cc/DZr9Kysx/bumba-cover.jpg",
            abstract: "Bumba <Wordt verwacht>",
            onTapped: () {},
          ),
          CategoryItem(
            title: "Category Dribbel",
            imageUrl: "https://i.postimg.cc/ydRvMQqB/dribbel-cover.jpg",
            abstract: "Dribbel <Wordt verwacht>",
            onTapped: () {},
          ),
        ],
      ),
    );
  }
}
