import 'package:flutter/material.dart';

import '../apis/interactive_books_api.dart';
import '../models/books_by_category.dart';
import 'book_item.dart';

// TODO Favorite aanpasbaar maken

// Wikitude
import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
//import '../pages/arnijntje.dart';
import '../pages/ardino.dart';

//audio player
import 'package:just_audio/just_audio.dart';

class BooksList extends StatefulWidget {
  final String category;
  const BooksList({Key? key, required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookListState();
}

class _BookListState extends State<BooksList> {
  late List<BooksByCategory> bookList = <BooksByCategory>[];

  //Wikitude
  List<String> features = ["image_tracking"];

  //Sound
  bool sound = false;

  //Audio track
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();

    String currentCategory = widget.category;
    _getBooksByCategory(currentCategory);

    //Audio
    String audioUrl = "assets/audio/$currentCategory.mp3";
    player = AudioPlayer();
    player.setLoopMode(LoopMode.all);
    Future.delayed(Duration.zero, () => player.setAsset(audioUrl));
  }

  void _getBooksByCategory(currentCategory) {
    InteractiveBooksApi.fetchBooksByCategory(currentCategory).then((result) {
      setState(() {
        bookList = result;
      });
    });
  }

  @override
  void dispose() {
    //dispose player
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Start player
    if (sound) {
      player.play();
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _soundControl();
        },
        backgroundColor: sound
            ? const Color.fromARGB(255, 136, 243, 141)
            : const Color.fromARGB(255, 251, 120, 120),
        child:
            sound ? const Icon(Icons.volume_up) : const Icon(Icons.volume_mute),
      ),
      body: _bookListItems(),
    );
  }

  ListView _bookListItems() {
    return ListView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 100),
        itemCount: bookList.length,
        itemBuilder: (context, position) {
          return BookItem(
            imageUrl: bookList[position].coverImageUrl,
            title: bookList[position].title,
            available: bookList[position].available,
            favorite: bookList[position].favorite,
            onTapped: () {
              if (bookList[position].available) {
                navigateToNijntje();
                const Text("Scan de pagina");
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Beschibaarheid',
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      'Dit boek is nog niet beschikbaar. \n We houden je op de hoogte.',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        });
  }

  void _soundControl() {
    setState(() {
      sound = !sound;
      player.playing ? player.stop() : player.play();
    });
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
                              builder: (context) => const ArDinoPage()),
                        ).then(
                          (value) => setState(
                              () {}), // For the player to start again after comming back from AR world
                        ),
                        player.stop(), // Pause the music player
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
