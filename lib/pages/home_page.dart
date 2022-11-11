import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/tabs/app_info_tab.dart';
import '../widgets/tabs/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Widget> data = [const HomeTab(), const InfoTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        /* backgroundColor: Colors.blueGrey,
        activeColor: Colors.white,
        inactiveColor: Colors.grey, 
        */

        // blauw:   backgroundColor: const Color.fromARGB(255, 21, 101, 192),
        backgroundColor: const Color.fromARGB(255, 46, 125, 50),
        activeColor: const Color.fromARGB(255, 253, 216, 53),
        inactiveColor: const Color.fromARGB(255, 245, 127, 23),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info",
          )
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return data[index];
          },
        );
      },
    ));
  }
}
