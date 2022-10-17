// book cover item widget

import 'package:flutter/material.dart';

typedef MyCallback = void Function();

class CategoryItem extends StatelessWidget {
  final String title, imageUrl, abstract;
  final MyCallback onTapped;

  const CategoryItem(
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
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            abstract,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }
}
