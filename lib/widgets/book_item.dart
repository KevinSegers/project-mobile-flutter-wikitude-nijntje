import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/models/book.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../apis/interactive_books_api.dart';
import '../pages/arnijntje.dart';

// This should be controlled by parent but then I had troubles with reloading the percentage...
// Solution? Make navigateToNijntje a class and use Navigator.push?

typedef MyCallback = void Function();

class BookItem extends StatefulWidget {
  final MyCallback changeFavorite;
  final Book book;

  const BookItem({
    Key? key,
    required this.changeFavorite,
    required this.book,
  }) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  late String percentageBookSeen = "0";
  //Wikitude
  List<String> features = ["image_tracking"];

  @override
  void initState() {
    super.initState();
    _getPercentageBookSeen(widget.book.title);
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

  void navigateToNijntje() {
    checkDeviceCompatibility().then((value) => {
          if (value.success)
            {
              requestARPermissions().then((value) => {
                    if (value.success)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArNijntjePage()),
                        ).then(
                          (value) => setState(() {
                            _getPercentageBookSeen(widget.book
                                .title); // Refresh percentage when coming back to booklist
                          }),
                        ),
                      }
                    else
                      {
                        debugPrint("AR permissions denied"),
                        debugPrint(value.message)
                      }
                  })
            }
          else
            {debugPrint("Device incompatible"), debugPrint(value.message)}
        });
  }

  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(features);
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
          if (percentageBookSeen != "0") {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title:
                          Text(widget.book.title, textAlign: TextAlign.center),
                      content: const Text(
                        'Wil je dit boek ongelezen zetten?',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Annuleren'),
                          child: const Text('Annuleren'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            _setBookUnseen(widget.book.title);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ));
          } else {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title:
                          Text(widget.book.title, textAlign: TextAlign.center),
                      content: const Text(
                        'Eens je dit boek aan het bekeken hebt kan je het terug ongelezen zetten.',
                        textAlign: TextAlign.center,
                      ),
                    ));
          }
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
          if (widget.book.available) {
            navigateToNijntje();
            const Text("Scan de pagina");
          } else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => const AlertDialog(
                title: Text(
                  'Beschibaarheid',
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'Dit boek is nog niet beschikbaar 🥲 \n We houden je op de hoogte.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
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
                      widget.book.coverImageUrl,
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
                        widget.book.title,
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
                        widget.book.available
                            ? "Beschikbaar"
                            : "Wordt verwacht",
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
                                widget.book.favorite ? filledStar : emptyStar
                              ]),
                              if (widget.book.available) ...[
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
