import 'package:book_pedia/data/models/books.dart';

abstract class BookRepository {
  Future<Books> fetchBooks({
    required String query,
    required int startIndex,
  });
}
