// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/enums/screen_status.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/login/data/models/login_response.dart';
import 'package:todo/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;
  LoginBloc(this.loginUseCase) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) {});

    on<LoginButtonEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatus.loading));
      var result = await loginUseCase(event.email, event.password);

      result.fold((l) {
        emit(state.copyWith(status: RequestStatus.failure, failures: l));
      }, (r) {
        emit(state.copyWith(status: RequestStatus.success, responseEntity: r));
      });
    });
  }
}
