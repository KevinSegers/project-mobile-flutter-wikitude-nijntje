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
          borderRadius: BorderRadius.circular(10), //border corner radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: const Offset(0, 2), // changes position of shadow
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
                  height: 100,
                  width: 100,
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
