import 'package:book_pedia/bloc/sign_up/sign_up_event.dart';
import 'package:book_pedia/bloc/sign_up/sign_up_state.dart';
import 'package:book_pedia/services/auth_service.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService _authService;

  SignUpBloc({required AuthService authService})
      : _authService = authService,
        super(SignUpInitial()) {
    on<SignUpWithEmailPressed>(_onSignUpWithEmailPressed);
    on<SignUpWithGoogle>(_onSignUpWithGoogle);
  }

  void _onSignUpWithEmailPressed(
    SignUpWithEmailPressed event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      final bookUser = await _authService.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (bookUser != null) {
        return emit(SignUpSuccess());
      } else {
        return emit(
            const SignUpFailure(error: "Something went wrong. Try again"));
      }
    } on Failure catch (e) {
      return emit(SignUpFailure(error: e.message));
    }
  }

  void _onSignUpWithGoogle(
    SignUpWithGoogle event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      final bookUser = await _authService.signInWithGoogle();

      if (bookUser != null) {
        return emit(SignUpSuccess());
      } else {
        return emit(
            const SignUpFailure(error: "Something went wrong. Try again"));
      }
    } on Failure catch (e) {
      return emit(SignUpFailure(error: e.message));
    }
  }
}
