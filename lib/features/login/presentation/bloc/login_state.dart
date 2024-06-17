// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

@immutable
class LoginState {
  RequestStatus? status;
  LoginResponse? responseEntity;
  Failures? failures;

  LoginState({this.status, this.responseEntity, this.failures});

  LoginState copyWith(
      {RequestStatus? status,
      LoginResponse? responseEntity,
      Failures? failures}) {
    return LoginState(
        status: status ?? this.status,
        failures: failures ?? this.failures,
        responseEntity: responseEntity ?? this.responseEntity);
  }
}

class LoginInitialState extends LoginState {
  LoginInitialState() : super(status: RequestStatus.init);
}
