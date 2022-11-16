import 'package:flutter/material.dart';

import '../apis/interactive_books_api.dart';
import '../models/book.dart';
import 'book_item.dart';

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

  //Loading indicator
  bool isLoading = false;

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
    isLoading = true;
    InteractiveBooksApi.fetchBooksByCategory(category).then((result) {
      setState(() {
        bookList = result;
        isLoading = false;
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
      //Floating action button to control sound
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _soundControl();
        },
        backgroundColor: sound
            ? const Color.fromARGB(255, 46, 125, 50)
            : const Color.fromARGB(255, 245, 127, 23),
        child:
            sound ? const Icon(Icons.volume_up) : const Icon(Icons.volume_mute),
      ),
      body: isLoading
          //Loading indicator if Loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Color.fromARGB(255, 46, 125, 50),
              semanticsLabel: 'Loading',
            ))
          //Book list if not loading
          : _bookListItems(),
    );
  }

  ListView _bookListItems() {
    return ListView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 100),
        itemCount: bookList.length,
        itemBuilder: (context, position) {
          return BookItem(
            book: bookList[position],
            changeFavorite: () {
              _updateFavorite(bookList[position]);
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
}
