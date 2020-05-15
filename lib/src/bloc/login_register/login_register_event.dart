import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginRegisterEvent extends Equatable {
  const LoginRegisterEvent();
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginRegisterEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginRegisterButtonPressed { username: $email, password: $password }';
}
class RegisterButtonPressed extends LoginRegisterEvent {
  final String email;
  final String password;
  final String username;

  const RegisterButtonPressed({
    @required this.email,
    @required this.password,
    @required this.username,
  });

  @override
  List<Object> get props => [email, password, username];

  @override
  String toString() =>
      'LoginRegisterButtonPressed { username: $email, password: $password }';
}

class LogOutButtonPressed extends LoginRegisterEvent {}