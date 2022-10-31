import 'package:flutter/material.dart';

import '../../pages/category_list_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

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
