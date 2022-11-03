import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/category.dart';

class InteractiveBooksApi {
  static String edgeService = '192.168.0.199:8050';

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
}
