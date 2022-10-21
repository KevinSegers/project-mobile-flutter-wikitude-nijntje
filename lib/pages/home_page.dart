import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/category_list.dart';
import '../widgets/app_info_tab.dart';
import '../widgets/home_tab.dart';

// TODO make homepage tab with CategoryListPage, ADD FavoritesPage and SettingsPage and link to tabs
//TODO make homepage stateful

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Widget> data = [const HomeTab(), const InfoPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.blueGrey,
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
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
