// book cover item widget

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../apis/interactive_books_api.dart';

typedef MyCallback = void Function();

class BookItem extends StatefulWidget {
  final String title, imageUrl;
  final bool available, favorite;
  final MyCallback onTapped, changeFavorite;

  const BookItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.available,
    required this.favorite,
    required this.onTapped,
    required this.changeFavorite,
  }) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  late String percentageBookSeen = "0";

  @override
  void initState() {
    super.initState();
    _getPercentageBookSeen(widget.title);
  }

  void _getPercentageBookSeen(bookTitle) {
    InteractiveBooksApi.fetchPercentageBookSeen(bookTitle).then((result) {
      setState(() {
        percentageBookSeen = result;
      });
    });
  }

  void _setBookUnseen(bookTitle) {
    InteractiveBooksApi.setBookUnseen(bookTitle);
    setState(() {
      percentageBookSeen = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    IconButton filledStar = IconButton(
        enableFeedback: true,
        iconSize: 30,
        color: const Color.fromARGB(255, 253, 216, 53),
        icon: const Icon(Icons.star),
        onPressed: () {
          widget.changeFavorite();
        });

    IconButton emptyStar = IconButton(
        enableFeedback: true,
        iconSize: 30,
        color: const Color.fromARGB(255, 253, 216, 53),
        icon: const Icon(Icons.star_outline_outlined),
        onPressed: () {
          widget.changeFavorite();
        });

    Widget percentageSeen = GestureDetector(
        onTap: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text(widget.title, textAlign: TextAlign.center),
                    content: const Text(
                      'Wil je dit boek ongelezen zetten?',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Annuleren'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          _setBookUnseen(widget.title);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        },
        child: (Column(children: [
          CircularPercentIndicator(
              radius: 21.0,
              lineWidth: 5.0,
              percent: double.parse(percentageBookSeen),
              center: Text(
                  "${(double.parse(percentageBookSeen) * 100).toStringAsFixed(0)}%"),
              progressColor: const Color.fromARGB(255, 46, 125, 50)),
        ])));

    return GestureDetector(
        onTap: () {
          widget.onTapped();
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
                      widget.imageUrl,
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
                        widget.title,
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
                        widget.available ? "Beschikbaar" : "Wordt verwacht",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //Favorite star

                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                widget.favorite ? filledStar : emptyStar
                              ]),
                              if (widget.available) ...[
                                percentageSeen,
                              ]
                            ])),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
