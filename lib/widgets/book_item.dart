// book cover item widget

import 'package:flutter/material.dart';

typedef MyCallback = void Function();

class BookItem extends StatelessWidget {
  final String title, imageUrl;
  final bool available, favorite;
  final MyCallback onTapped;

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
      required this.available,
      required this.favorite,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapped();
        },

        //Container with boxShadow
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
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
          child: Row(
            children: <Widget>[
              //Image
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrl,
                      height: 80,
                      width: 80,
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

                    //Title
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    //Availability
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        textAlign: TextAlign.end,
                        available ? "Beschikbaar" : "Wordt verwacht",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    //Favorite star
                    favorite ? filledStar : emptyStar
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
