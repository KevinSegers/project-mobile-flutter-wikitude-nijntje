import 'package:flutter/material.dart';

import '../widgets/category_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR kinder boeken"),
        centerTitle: true,
      ),
      body: const CategoryListPage(),
    );
  }
}
