import 'dart:io';

import 'package:book_pedia/data/models/book/book_item.dart';
import 'package:book_pedia/domain/repositories/database_repository.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:book_pedia/utilities/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  final _db = FirebaseFirestore.instance;

  List<DocumentSnapshot> _lastDocumentSnapshot = [];

  @override
  Future<bool> getFavoriteStatus({
    required String userId,
    required BookItem bookItem,
  }) async {
    try {
      final documentSnapshot = await _db
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .doc(bookItem.id)
          .get();

      if (documentSnapshot.exists) return true;

      return false;
    } on FirebaseException catch (e) {
      throw Failure(e.message ?? kFirebaseExceptionMessage);
    } on SocketException {
      throw Failure(kSocketExceptionMessage);
    } catch (_) {
      throw Failure(kCatchErrorMessage);
    }
  }

  @override
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
    } on FirebaseException catch (e) {
      throw Failure(e.message ?? kFirebaseExceptionMessage);
    } on SocketException {
      throw Failure(kSocketExceptionMessage);
    } catch (_) {
      throw Failure(kCatchErrorMessage);
    }
  }

  @override
  Future<void> removeBookItemFromFavorite(
      {required String userId, required BookItem bookItem,}) async {
    try {
      _db
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .doc(bookItem.id)
          .delete();
    } on FirebaseException catch (e) {
      throw Failure(e.message ?? kFirebaseExceptionMessage);
    } on SocketException {
      throw Failure(kSocketExceptionMessage);
    } catch (_) {
      throw Failure(kCatchErrorMessage);
    }
  }

  @override
  Future<List<BookItem>> fetchFavoriteBooks({required String userId}) async {
    try {
      List<BookItem> bookItems = [];
      QuerySnapshot querySnapshot = await _db
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .orderBy("timeStamp", descending: true)
          .limit(10)
          .get();

      if (querySnapshot.size == 0) {
        return bookItems;
      }

      List<DocumentSnapshot> listOfDocumentSnapshot = querySnapshot.docs;
      _saveLastDocumentSnapshot(listOfDocumentSnapshot);

      final result = listOfDocumentSnapshot.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        BookItem bookItem = BookItem.fromJson(data);
        return bookItem;
      }).toList();

      bookItems = result;
      return bookItems;
    } on FirebaseException catch (e) {
      throw Failure(e.message ?? kFirebaseExceptionMessage);
    } on SocketException {
      print("DatabaseService => fetchFavoriteBooks == No internet connection");
      throw Failure(kSocketExceptionMessage);
    } catch (_) {
      throw Failure(kCatchErrorMessage);
    }
  }

  @override
  Future<List<BookItem>> fetchNextFavoriteBooks(
      {required String userId}) async {
    try {
      List<BookItem> bookItems = [];
      QuerySnapshot querySnapshot = await _db
          .collection("users")
          .doc(userId)
          .collection("favorites")
          .orderBy("timeStamp", descending: true)
          .startAfterDocument(
          _lastDocumentSnapshot[_lastDocumentSnapshot.length - 1])
          .limit(10)
          .get();

      if (querySnapshot.size == 0) {
        return bookItems;
      }

      List<DocumentSnapshot> listOfDocumentSnapshot = querySnapshot.docs;
      _saveLastDocumentSnapshot(listOfDocumentSnapshot);

      final result = listOfDocumentSnapshot.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        BookItem bookItem = BookItem.fromJson(data);
        return bookItem;
      }).toList();

      bookItems = result;
      return bookItems;
    } on FirebaseException catch (e) {
      throw Failure(e.message ?? kFirebaseExceptionMessage);
    } on SocketException {
      print("DatabaseService => fetchFavoriteBooks == No internet connection");
      throw Failure(kSocketExceptionMessage);
    } catch (_) {
      throw Failure(kCatchErrorMessage);
    }
  }

  void _saveLastDocumentSnapshot(List<DocumentSnapshot> lastDocumentSnapshot) {
    _lastDocumentSnapshot = lastDocumentSnapshot;

    print(
        "DatabaseService -> _saveLastDocumentSnapshot == lastDocumentSnapshot saved!!!");
  }
}
