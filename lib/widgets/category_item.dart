// book cover item widget

import 'package:flutter/material.dart';

typedef MyCallback = void Function();

class CategoryItem extends StatelessWidget {
  final String imageUrl, categoryName;
  final MyCallback onTapped;

  const CategoryItem(
      {Key? key,
      required this.imageUrl,
      required this.categoryName,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                categoryName,
                style: const TextStyle(color: Colors.black54, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
