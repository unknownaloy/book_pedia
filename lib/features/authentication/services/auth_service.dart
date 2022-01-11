import 'dart:io';

import 'package:book_pedia/common/models/book_user.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:book_pedia/utilities/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<BookUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      BookUser? bookUser = BookUser(
        id: user?.uid,
        email: user?.email,
      );
      return bookUser;
    } on FirebaseException catch (e) {
      throw Failure(e.message ?? kFirebaseExceptionMessage);
    } on SocketException {
      throw Failure(kSocketExceptionMessage);
    } catch (_) {
      throw Failure(kCatchErrorMessage);
    }
  }

  Future<BookUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);

      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        BookUser bookUser = BookUser(
          id: currentUser.uid,
          email: currentUser.email,
        );

        return bookUser;
      }
    } on FirebaseAuthException catch (e) {
      throw Failure(e.message ?? kFirebaseAuthExceptionMessage);
    } on SocketException {
      throw Failure(kSocketExceptionMessage);
    } catch (e) {
      throw Failure(kCatchErrorMessage);
    }
  }

  Future<BookUser?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      BookUser? bookUser = BookUser(id: user?.uid, email: user?.email);
      return bookUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Failure("The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        throw Failure("The account already exists for that email");
      }
    } on SocketException {
      throw Failure(kSocketExceptionMessage);
    } catch (_) {
      throw Failure(kSocketExceptionMessage);
    }
  }

  bool isSignedIn() {
    final currentUser = _auth.currentUser;

    return currentUser != null;
  }

  BookUser getUser() {
    User? user = _auth.currentUser;
    BookUser? bookUser = BookUser(id: user?.uid, email: user?.email!);
    return bookUser;
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}