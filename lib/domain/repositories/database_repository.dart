import 'package:book_pedia/data/models/book/book_item.dart';

abstract class DatabaseRepository {
  Future<bool> getFavoriteStatus({
    required String userId,
    required BookItem bookItem,
  });

  Future<void> addBookItemToFavorite({
    required String userId,
    required BookItem bookItem,
  });

  Future<void> removeBookItemFromFavorite({
    required String userId,
    required BookItem bookItem,
  });

  Future<List<BookItem>> fetchFavoriteBooks({required String userId});

  Future<List<BookItem>> fetchNextFavoriteBooks({required String userId});
}
