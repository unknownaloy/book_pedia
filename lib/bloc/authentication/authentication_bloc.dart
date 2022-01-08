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
        super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthenticationState> emit) {
    try {
      final isSignedIn = _authService.isSignedIn();

      if (isSignedIn) {
        final bookUser = _authService.getUser();
        Global.bookUser = bookUser;
        return emit(Authenticated(bookUser: bookUser));
      } else {
        return emit(Unauthenticated());
      }
    } catch (e) {
      return emit(Unauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) {
    final bookUser = _authService.getUser();
    Global.bookUser = bookUser;
    return emit(Authenticated(bookUser: bookUser));
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) {
    emit(Unauthenticated());
    _authService.logOut();
  }
}
