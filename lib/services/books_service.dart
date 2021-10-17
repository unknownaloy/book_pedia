import 'dart:convert';

import 'package:book_pedia/api_keys/books_api.dart';
import 'package:book_pedia/models/book_model/books.dart';
import 'package:http/http.dart' as http;

class BooksService {
  final http.Client _client = http.Client();

  Future<Books> fetchFamousBooks() async {
    try {
      Map<String, String> queryParams = {
        "q": "famous books",
        "client_id": clientId,
      };

      var uri =
          Uri.https("www.googleapis.com", "/books/v1/volumes/", queryParams);

      final response = await _client.get(uri);

      if (response.statusCode == 200) {

        final data = response.body;

        final decodedData = jsonDecode(data);

        Books book = Books.fromJson(decodedData);

        return book;
      } else {
        throw Exception("Couldn't get data");
      }
    } catch (e) {
      print("$e => FROM FETCH DATA");
      throw Exception("Something went wrong. Please try again");
    }
  }
}
