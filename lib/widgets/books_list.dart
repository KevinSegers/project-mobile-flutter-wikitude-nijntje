import 'package:flutter/material.dart';

import '../apis/interactive_books_api.dart';
import '../models/book.dart';
import 'book_item.dart';

// Wikitude
import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import '../pages/arnijntje.dart';

//audio player
import 'package:just_audio/just_audio.dart';

class BooksList extends StatefulWidget {
  final String category;

  const BooksList({Key? key, required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookListState();
}

class _BookListState extends State<BooksList> {
  late List<Book> bookList = <Book>[];

  //Wikitude
  List<String> features = ["image_tracking"];

  //Sound
  bool sound = false;

  //Audio track
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();

    _getBooksByCategory(widget.category);

    //Audio
    String audioUrl = "assets/audio/${widget.category}.mp3";
    player = AudioPlayer();
    player.setLoopMode(LoopMode.all);
    Future.delayed(Duration.zero, () => player.setAsset(audioUrl));
  }

  void _getBooksByCategory(category) {
    InteractiveBooksApi.fetchBooksByCategory(category).then((result) {
      setState(() {
        bookList = result;
      });
    });
  }

  void _updateFavorite(Book book) {
    setState(() {
      book.favorite = !book.favorite;
      InteractiveBooksApi.updateBook(book);
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
            // ? const Color.fromARGB(255, 136, 243, 141)
            ? const Color.fromARGB(255, 46, 125, 50)
            //   : const Color.fromARGB(255, 251, 120, 120),
            : const Color.fromARGB(255, 245, 127, 23),
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
            changeFavorite: () {
              _updateFavorite(bookList[position]);
            },
            onTapped: () {
              if (bookList[position].available) {
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
                              builder: (context) => const ArNijntjePage()),
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
