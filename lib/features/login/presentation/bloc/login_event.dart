part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonEvent extends LoginEvent {
  String email;
  String password;

  LoginButtonEvent(this.email, this.password);
}
