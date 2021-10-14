import 'dart:io';

import 'package:book_pedia/models/book_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<BookUser?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      BookUser bookUser = BookUser(id: user!.uid, email: user.email!);
      return bookUser;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  bool isSignedIn() {
    final currentUser = _auth.currentUser;

    return currentUser != null;
  }

  BookUser getUser() {
    User? user = _auth.currentUser;
    BookUser? bookUser = BookUser(id: user!.uid, email: user.email!);
    return bookUser;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
