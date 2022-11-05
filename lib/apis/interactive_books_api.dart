import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/books_by_category.dart';
import '../models/category.dart';

class InteractiveBooksApi {
  //Kevin
  //static String edgeService = '192.168.0.199:8050';

  //michal
  static String edgeService = 'chubby-hands-grin-84-197-131-83.loca.lt';

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
}
