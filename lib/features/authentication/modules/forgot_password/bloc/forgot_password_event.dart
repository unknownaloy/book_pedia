import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SubmitEmailForReset extends ForgotPasswordEvent {
  final String email;

  const SubmitEmailForReset(this.email);

  @override
  List<Object> get props => [email];
}