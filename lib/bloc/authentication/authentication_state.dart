import 'package:book_pedia/models/book_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final BookUser bookUser;

  const Authenticated({required this.bookUser});

  @override
  List<Object> get props => [bookUser];
}

class Unauthenticated extends AuthenticationState {}
