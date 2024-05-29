part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonEvent extends LoginEvent {
  String email;
  String password;

  LoginButtonEvent(this.email, this.password);
}
