import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginRegisterState extends Equatable {
  const LoginRegisterState();

  @override
  List<Object> get props => [];
}

class LoginRegisterInitial extends LoginRegisterState {}

class LoginRegisterLoading extends LoginRegisterState {}

class LoginRegisterSuccess extends LoginRegisterState {}

class LoginRegisterFailure extends LoginRegisterState {
  final String error;

  const LoginRegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginRegisterFailure { error: $error }';
}

class LogoutSuccess extends LoginRegisterState {}

class LogoutFailure extends LoginRegisterState {
  final String error;

  const LogoutFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginRegisterFailure { error: $error }';
}