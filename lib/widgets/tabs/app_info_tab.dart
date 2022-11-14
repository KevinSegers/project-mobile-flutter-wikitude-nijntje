import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info over de app"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            padding: const EdgeInsets.only(left: 5.0, top: 10.0),
            child: Column(
              children: const <Widget>[
                Text(
                  "Kies een boek van je favoriet personage en zie de avonturen die ze beleven tot leven komen!",
                  style: TextStyle(fontSize: 18, height: 2),
                ),
                SizedBox(height: 15),
                Text(
                  "Om de app te kunnen gebruiken heb je toegang tot het internet nodig.",
                  style: TextStyle(fontSize: 18, height: 2),
                ),
                SizedBox(height: 15),
                Text(
                  "Deze app werd ontwikkeld voor het vak Mobile development door Kevin Segers en Michal Davidse.",
                  style: TextStyle(fontSize: 18, height: 2),
                ),
              ],
            )),
      ),
    );
  }
}
