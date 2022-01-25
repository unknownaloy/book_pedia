import 'package:book_pedia/data/models/book_user.dart';

abstract class AuthRepository {
  Future<BookUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<BookUser?> signInWithGoogle();

  Future<BookUser?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> forgotPassword(String email);

  bool isSignedIn();

  BookUser getUser();

  Future<void> logOut();
}
