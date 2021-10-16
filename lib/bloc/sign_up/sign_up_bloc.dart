import 'package:book_pedia/bloc/sign_up/sign_up_event.dart';
import 'package:book_pedia/bloc/sign_up/sign_up_state.dart';
import 'package:book_pedia/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService _authService;

  SignUpBloc({required AuthService authService})
      : _authService = authService,
        super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpWithEmailPressed) {
      yield* _mapSignUpWithEmailPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SignUpState> _mapSignUpWithEmailPressedToState({
    required String email,
    required String password,
  }) async* {
    yield SignUpLoading();

    try {
      final bookUser = await _authService.signUpWithEmailAndPassword(
          email: email, password: password,);

      if (bookUser != null) {
        yield SignUpSuccess();
      } else {
        yield const SignUpFailure(error: "Something went wrong. Try again");
      }
    } catch (e) {
      yield const SignUpFailure(error: "Try again");
    }
  }
}
