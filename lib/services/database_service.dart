import 'package:book_pedia/models/book_model/book_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Future<bool> getFavoriteStatus({
    required String userId,
    required BookItem bookItem,
  }) async {
    try {
     final documentSnapshot = await _db
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .doc(bookItem.id).get();

     if (documentSnapshot.exists) return true;

     return false;
    } catch (e) {
      print("DatabaseService => getFavoriteStatus == $e");
      throw Exception("Couldn't get favorite status");
    }
  }

  Future<void> addBookItemToFavorite({
    required String userId,
    required BookItem bookItem,
  }) async {
    try {
      _db
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .doc(bookItem.id)
          .set(bookItem.toJson());
    } catch (e) {
      print("DatabaseService => addBookToFavorite == $e");
    }
  }

  Future<void> removeBookItemFromFavorite({
    required String userId,
    required BookItem bookItem,
  }) async {
    try {
      _db
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .doc(bookItem.id)
          .delete();
    } catch (e) {
      print("DatabaseService => removeBookItemFromFavorite == $e");
    }
  }
}
