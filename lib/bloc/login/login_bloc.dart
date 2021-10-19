import 'package:book_pedia/bloc/login/login_event.dart';
import 'package:book_pedia/bloc/login/login_state.dart';
import 'package:book_pedia/services/auth_service.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;

  LoginBloc({required AuthService authService})
      : _authService = authService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailPressed) {
      yield* _mapLoginInWithEmailPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is LoginInWithGoogle) {
      yield* _mapLoginInWithGoogleToState();
    }

  }

  Stream<LoginState> _mapLoginInWithEmailPressedToState({
    required String email,
    required String password,
  }) async* {
    yield LoginLoading();

    try {
      final bookUser = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (bookUser != null) {
        yield LoginSuccess();
      } else {
        yield const LoginFailure(error: "Something went wrong. Try again");
      }
    } on Failure catch (e) {
      yield LoginFailure(error: e.message);
    }
  }

  Stream<LoginState> _mapLoginInWithGoogleToState() async* {
    yield LoginLoading();

    try {
      final bookUser = await _authService.signInWithGoogle();

      if (bookUser != null) {
        yield LoginSuccess();
      } else {
        yield const LoginFailure(error: "Something went wrong. Try again");
      }
    } on Failure catch (e) {
      yield LoginFailure(error: e.message);
    }
  }
}
