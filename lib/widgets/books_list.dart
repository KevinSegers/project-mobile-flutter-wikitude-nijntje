// photoWidget met Title 1/8 bv of Wordt verwacht
// click action naar wikitude bij beschikbare boeken
// eventueel like button

//TODO refactor from hard coded books to dynamic books => see post_list.dart in de NYT app
//TODO klikbare items met functie die controleert op beschikbaarheid => weergeven in tekst
//bij het item en bij klikken popup ofzo dat het item nog niet beschikbaar is

import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/widgets/tabs/settings_tab.dart';

import 'book_item.dart';

// Wikitude
import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import '../pages/arnijntje.dart';

//audio player
import 'package:just_audio/just_audio.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookListState();
}

class _BookListState extends State<BooksList> {
  //Wikitude
  List<String> features = ["image_tracking"];

  //Audio track
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    String category = "Nijntje"; //TODO replace with DB category
    String audioUrl = "assets/audio/$category.mp3";
    player = AudioPlayer();
    player.setLoopMode(LoopMode.all);
    Future.delayed(Duration.zero, () => player.setAsset(audioUrl));
  }

  @override
  void dispose() {
    //dispose player
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    player.play(); //Start player
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
              navigateToNijntje();
              const Text("Scan de pagina");
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

  void navigateToNijntje() {
    debugPrint("Wij gaan naar Nijntje");

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
                          (value) => setState(
                              () {}), // For the player to start again after comming back from AR world
                        ),
                        player.pause(), // Pause the music player
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
