import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/pages/home_page.dart';

void main() {
  runApp(const ARBooksApp());
}

class ARBooksApp extends StatelessWidget {
  const ARBooksApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR - Books',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}
