import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/network/model/response.dart';

@immutable
class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess(this.response);
  final Response? response;

  Response? get getResponse => response;
}

class LoginFailure extends LoginState {
  final Response? error;
  final String? networkError;
  LoginFailure({this.error,this.networkError});

  Response? get getError => error;
  String? get getNetworkError => networkError;

  @override
  List<Response?> get props => [error];
}
