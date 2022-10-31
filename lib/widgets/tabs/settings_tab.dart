import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  SettingsTabState createState() {
    return SettingsTabState();
  }
}

class SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            children: const <Widget>[
              Text(
                'Categorie geluid',
                style: TextStyle(fontSize: 25),
              ),
              Expanded(
                child: Sound(),
              ),
            ],
          ),
        ));
  }
}

class Sound extends StatefulWidget {
  const Sound({Key? key}) : super(key: key);

  @override
  State<Sound> createState() => SoundState();
}

class SoundState extends State<Sound> {
  bool soundState = true;
  @override
  Widget build(BuildContext context) {
    return Switch(
      // thumb color (round icon)
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey.shade400,
      activeColor: Colors.blueGrey.shade600,
      activeTrackColor: Colors.blueGrey.shade300,
      splashRadius: 50.0,
      // boolean variable value
      value: soundState,
      // changes the state of the switch
      onChanged: (value) => setState(() => soundState = value),
    );
  }
}
