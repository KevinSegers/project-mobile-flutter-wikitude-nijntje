// book cover item widget

import 'package:flutter/material.dart';

typedef MyCallback = void Function();

class BookItem extends StatelessWidget {
  final String title, imageUrl, abstract;
  final MyCallback onTapped;
  final available = false;
  final favorite = false;

  static IconButton filledStar = IconButton(
      iconSize: 30,
      color: Colors.yellow,
      icon: const Icon(Icons.star),
      onPressed: () {});

  static IconButton emptyStar = IconButton(
      iconSize: 30,
      color: Colors.yellow,
      icon: const Icon(Icons.star_outline_outlined),
      onPressed: () {});

  const BookItem(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.abstract,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: 120,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Text(
                  abstract,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  textAlign: TextAlign.end,
                  available ? "Beschikbaar" : "Wordt verwacht",
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                favorite ? filledStar : emptyStar
              ],
            ),
          )
        ],
      ),
    );
  }
}
