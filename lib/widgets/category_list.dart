// overzicht met photoWidget + naam van categorie + aantal books
// click action naar book_list.dart => category doorgeven

import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/widgets/books_list.dart';

import 'category_item.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

//TODO refactor from hard coded categories to dynamic categories => see post_list.dart in de NYT app
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BooksListPage()),
              );
            },
          ),
          CategoryItem(
            title: "Categeory Bumba",
            imageUrl: "https://i.postimg.cc/DZr9Kysx/bumba-cover.jpg",
            abstract: "Bumba <Under Construction>",
            onTapped: () {},
          ),
          CategoryItem(
            title: "Category Dribbel",
            imageUrl: "https://i.postimg.cc/ydRvMQqB/dribbel-cover.jpg",
            abstract: "Dribbel <Under Construction>",
            onTapped: () {},
          ),
        ],
      ),
    );
  }
}
