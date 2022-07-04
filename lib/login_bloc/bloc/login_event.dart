import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoLoginWithUserNameAndPassword extends LoginEvent {
  final String username;
  final String password;

  DoLoginWithUserNameAndPassword(
      {required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
