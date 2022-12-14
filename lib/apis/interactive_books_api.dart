import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book.dart';
import '../models/category.dart';
import '../globals/globals.dart' as globals;
import '../models/page.dart';

class InteractiveBooksApi {
  static String edgeService = globals.globalEdgeService;

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
  static Future<List<Book>> fetchBooksByCategory(String category) async {
    category = category.toUpperCase();
    var url =
        Uri.http(edgeService, '/interactivebooks/booksbycategory/$category');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((books) => Book.fromJson(books)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  //update Book
  static Future<Book> updateBook(
    Book book,
  ) async {
    var url = Uri.http(edgeService, 'interactivebooks/updatebook');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(book),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  // fetch percentage of seen pages of a book
  static Future<String> fetchPercentageBookSeen(String bookTitle) async {
    var url =
        Uri.http(edgeService, '/interactivebooks/books/$bookTitle/pagesseen');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load');
    }
  }

  // reset seen pages of a book
  static Future<List<dynamic>> setBookUnseen(String bookTitle) async {
    var url = Uri.http(
        edgeService, '/interactivebooks/books/$bookTitle/setpagesunseen');

    var response = await http.put(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((page) => Page.fromJson(page as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to reset pages');
    }
  }
}
