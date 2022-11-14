import 'package:flutter/material.dart';
import 'package:nijntje_is_alive/pages/home_page.dart';

import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // App will always run in portrait mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const ARBooksApp());
  });
}

class ARBooksApp extends StatelessWidget {
  const ARBooksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR - Books',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 46, 125, 50),
        ),
      ),
      home: const HomePage(),
    );
  }
}
