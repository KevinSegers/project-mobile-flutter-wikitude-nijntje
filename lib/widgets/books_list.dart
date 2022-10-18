// photoWidget met Title 1/8 bv of Wordt verwacht
// click action naar wikitude bij beschikbare boeken
// eventueel like button

import 'package:flutter/material.dart';

import 'book_item.dart';

class BooksList extends StatelessWidget {
  const BooksList({Key? key}) : super(key: key);

//TODO refactor from hard coded books to dynamic books => see post_list.dart in de NYT app
//TODO klikbare items met functie die controleert op beschikbaarheid => weergeven in tekst
//bij het item en bij klikken popup ofzo dat het item nog niet beschikbaar is
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: (1 / .4),
        primary: false,
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 0,
        crossAxisCount: 1,
        children: <Widget>[
          BookItem(
            title: "Boeken Nijntje",
            imageUrl: "https://i.postimg.cc/RFrDZ6zc/Nijntjeindespeeltuin.jpg",
            abstract: "Nijntje in de speeltuin",
            onTapped: () {},
          ),
          BookItem(
            title: "Boeken Nijntje",
            imageUrl: "https://i.postimg.cc/RFrDZ6zc/Nijntjeindespeeltuin.jpg",
            abstract: "Nijntje in de speeltuin",
            onTapped: () {},
          ),
          BookItem(
            title: "Boeken Nijntje",
            imageUrl: "https://i.postimg.cc/RFrDZ6zc/Nijntjeindespeeltuin.jpg",
            abstract: "Nijntje in de speeltuin",
            onTapped: () {},
          ),
        ],
      ),
    );
  }
}
