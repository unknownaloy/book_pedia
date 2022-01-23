import 'dart:convert';
import 'dart:io';

import 'package:book_pedia/config/api_keys/books_api.dart';
import 'package:book_pedia/data/models/books.dart';
import 'package:book_pedia/domain/repositories/book_repository.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:book_pedia/utilities/strings.dart';
import 'package:http/http.dart' as http;

class BookRepositoryImpl extends BookRepository {

  final http.Client _client = http.Client();

  @override
  Future<Books> fetchBooks({
    String query = "famous books",
    int startIndex = 0,
  }) async {
    try {
      Map<String, String> queryParams = {
        "q": query,
        "client_id": clientId,
        "startIndex": startIndex.toString(),
      };

      var uri =
      Uri.https("www.googleapis.com", "/books/v1/volumes/", queryParams);

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = response.body;

        final decodedData = jsonDecode(data);

        Books books = Books.fromJson(decodedData);

        return books;
      } else {
        throw Exception();
      }
    } on SocketException catch (_) {
      throw Failure(kSocketExceptionMessage);
    } on HttpException {
      throw Failure(kHttpExceptionMessage);
    } catch (e) {
      throw Failure(kCatchErrorMessage);
    }
  }
}
