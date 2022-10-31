import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/tabs/app_info_tab.dart';
import '../widgets/tabs/home_tab.dart';
import '../widgets/tabs/settings_tab.dart';

// TODO make homepage tab with CategoryListPage, ADD FavoritesPage and SettingsPage and link to tabs
//TODO make homepage stateful

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Widget> data = [const HomeTab(), const InfoTab(), const SettingsTab()];

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
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
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
