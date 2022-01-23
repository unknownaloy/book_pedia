import 'package:book_pedia/data/repositories/auth_repository_impl.dart';
import 'package:book_pedia/features/authentication/modules/login/bloc/login_event.dart';
import 'package:book_pedia/features/authentication/modules/login/bloc/login_state.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryImpl _authService;

  LoginBloc({required AuthRepositoryImpl authService})
      : _authService = authService,
        super(LoginInitial()) {
    on<LoginInWithEmailPressed>(_onLoginInWithEmailPressed);
    on<LoginInWithGoogle>(_onLoginInWithGoogle);
  }

  void _onLoginInWithEmailPressed(
    LoginInWithEmailPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final bookUser = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (bookUser != null) {
        return emit(LoginSuccess());
      } else {
        return emit(
            const LoginFailure(error: "Something went wrong. Try again"));
      }
    } on Failure catch (e) {
      return emit(LoginFailure(error: e.message));
    }
  }

  void _onLoginInWithGoogle(LoginInWithGoogle event, Emitter<LoginState> emit,) async {
    emit(LoginLoading());

    try {
      final bookUser = await _authService.signInWithGoogle();

      if (bookUser != null) {
        return emit(LoginSuccess());
      } else {
        return emit(const LoginFailure(error: "Something went wrong. Try again"));
      }
    } on Failure catch (e) {
      return emit(LoginFailure(error: e.message));
    }
  }

}
