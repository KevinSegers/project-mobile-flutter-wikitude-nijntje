// photoWidget met Title 1/8 bv of Wordt verwacht
// click action naar wikitude bij beschikbare boeken
// eventueel like button

//TODO refactor from hard coded books to dynamic books => see post_list.dart in de NYT app
//TODO klikbare items met functie die controleert op beschikbaarheid => weergeven in tekst
//bij het item en bij klikken popup ofzo dat het item nog niet beschikbaar is
import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter/material.dart';

import '../pages/ardino.dart';
import 'book_item.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookListState();
}

class _BookListState extends State<BooksList> {
  List<String> features = ["image_tracking"];

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
            onTapped: () {
              navigateToDinos();
              const Text("Scan the Dino's!");
            },
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

  void navigateToDinos() {
    debugPrint("Wij gaan naar dino's");

    checkDeviceCompatibility().then((value) => {
          if (value.success)
            {
              requestARPermissions().then((value) => {
                    if (value.success)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArDinoPage()),
                        )
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
}
