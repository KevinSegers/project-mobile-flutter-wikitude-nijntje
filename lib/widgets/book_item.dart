// book cover item widget

import 'package:flutter/material.dart';

typedef MyCallback = void Function();

class BookItem extends StatelessWidget {
  final String title, imageUrl, abstract;
  final MyCallback onTapped;

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
            child: Text(
              abstract,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
