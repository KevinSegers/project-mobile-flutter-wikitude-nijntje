import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/books_by_category.dart';
import '../models/category.dart';
import '../models/page.dart';

class InteractiveBooksApi {
  //Kevin
  //static String edgeService = '192.168.0.199:8050';

  //michal
  static String edgeService = 'slimy-trees-greet-84-197-131-83.loca.lt';

  //FetchCategoriesWithUrls
  static Future<List<Category>> fetchCategoriesWithUrls() async {
    var url = Uri.http(edgeService, '/interactivebooks/categorieswithurls');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  //FetchBooksByCategory
  static Future<List<BooksByCategory>> fetchBooksByCategory(
      String category) async {
    category = category.toUpperCase();
    var url =
        Uri.http(edgeService, '/interactivebooks/booksbycategory/$category');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((books) => BooksByCategory.fromJson(books))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  //update Book

  //updateSeen
  static Future<Page> updatePage(
    Page page,
  ) async {
    var url = Uri.http(edgeService, 'interactivebooks/');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(page),
    );

    if (response.statusCode == 200) {
      return Page.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
