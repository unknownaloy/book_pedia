import 'package:book_pedia/bloc/login/login_event.dart';
import 'package:book_pedia/bloc/login/login_state.dart';
import 'package:book_pedia/services/auth_service.dart';
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
    } catch (e) {
      // Handle error here
      yield const LoginFailure(error: "Try again");
    }
  }
}
