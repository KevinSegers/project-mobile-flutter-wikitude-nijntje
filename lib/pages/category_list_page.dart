// overzicht met photoWidget + naam van categorie + aantal books
// click action naar book_list.dart => category doorgeven

import 'package:flutter/material.dart';

import 'books_by_category_list_page.dart';
import '../widgets/category_item.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

//TODO refactor from hard coded categories to dynamic categories => see post_list.dart in de NYT app
//TODO klikbare items met functie die controleert op beschikbaarheid => weergeven in tekst
//bij het item en bij klikken popup ofzo dat het item nog niet beschikbaar is
//TODO check every category for content => if not available => disable click action and add a <Wordt verwacht> text

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
