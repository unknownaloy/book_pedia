import 'package:book_pedia/data/repositories/auth_repository_impl.dart';
import 'package:book_pedia/features/authentication/modules/forgot_password/bloc/forgot_password_event.dart';
import 'package:book_pedia/features/authentication/modules/forgot_password/bloc/forgot_password_state.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepositoryImpl _authService;

  ForgotPasswordBloc(AuthRepositoryImpl authService)
      : _authService = authService,
        super(ForgotPasswordIdle()) {
    on<SubmitEmailForReset>(_onSubmitEmailForReset);
  }

  void _onSubmitEmailForReset(
    SubmitEmailForReset event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());

    try {
      await _authService.forgotPassword(event.email);
      return emit(ForgotPasswordSuccess());
    } on Failure catch (e) {
      return emit(ForgotPasswordFailure(e.message));
    }
  }
}
