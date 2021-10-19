import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithEmailPressed extends SignUpEvent {
  final String email;
  final String password;

  const SignUpWithEmailPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpWithGoogle extends SignUpEvent {}