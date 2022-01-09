import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInWithEmailPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginInWithEmailPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginInWithGoogle extends LoginEvent {}
