part of 'login_bloc.dart';

class LoginState {
  RequestStatus? status;
  ResponseEntity? entity;
  Failures? failures;

  LoginState({this.status, this.entity, this.failures});

  LoginState copWith(
      {RequestStatus? status, ResponseEntity? entity, Failures? failures}) {
    return LoginState(
        entity: entity ?? this.entity,
        status: status ?? this.status,
        failures: failures ?? this.failures);
  }
}

class LoginInitState extends LoginState {
  LoginInitState() : super(status: RequestStatus.init);
}
