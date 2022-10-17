// overzicht met photoWidget + naam van categorie + aantal books
// click action naar book_list.dart => category doorgeven

import 'package:flutter/material.dart';

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
            title: "Kinderboeken",
            imageUrl: "https://i.postimg.cc/3wpjLy5b/nijntje-cover.jpg",
            abstract: "Nijntje",
            onTapped: () {},
          ),
          CategoryItem(
            title: "Kinderboeken",
            imageUrl: "https://i.postimg.cc/DZr9Kysx/bumba-cover.jpg",
            abstract: "Bumba <Under Construction>",
            onTapped: () {},
          ),
          CategoryItem(
            title: "Kinderboeken",
            imageUrl: "https://i.postimg.cc/ydRvMQqB/dribbel-cover.jpg",
            abstract: "Dribbel <Under Construction>",
            onTapped: () {},
          ),
        ],
      ),
    );
  }
}
