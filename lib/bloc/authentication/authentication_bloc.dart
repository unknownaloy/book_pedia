import 'package:book_pedia/bloc/authentication/authentication_event.dart';
import 'package:book_pedia/bloc/authentication/authentication_state.dart';
import 'package:book_pedia/services/auth_service.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;

  AuthenticationBloc({required AuthService authService})
      : _authService = authService,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(
      AuthenticationEvent event) async* {
    try {
      print("Inside the _mapAppStartedToState");
      // TODO: Save user's data to SharedPreferences and check data there
      final isSignedIn = _authService.isSignedIn();

      if (isSignedIn) {
        final bookUser = _authService.getUser();
        Global.bookUser = bookUser;
        yield Authenticated(bookUser: bookUser);
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      AuthenticationEvent event) async* {
    final bookUser = _authService.getUser();
    Global.bookUser = bookUser;
    yield Authenticated(bookUser: bookUser);
  }

  Stream<AuthenticationState> _mapLoggedOutToState(AuthenticationEvent event) async* {
    yield Unauthenticated();
    _authService.logOut();
  }
}
