import 'package:flutter/material.dart';
import '../widgets/arnijntjetargets.dart';

class ArNijntjePage extends StatefulWidget {
  const ArNijntjePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArNijntjePageState();
}

class _ArNijntjePageState extends State<ArNijntjePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kinderboeken"),
      ),
      body: const Center(
          // Here we load the Widget with the AR experience
          child: ArNijntjeTargetsWidget()),
    );
  }
}
