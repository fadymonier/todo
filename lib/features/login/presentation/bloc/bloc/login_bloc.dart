import 'package:bloc/bloc.dart';
import 'package:promina_task/core/cache/shared_prefs.dart';
import 'package:promina_task/core/enums/screen_status.dart';
import 'package:promina_task/core/errors/failures.dart';
import 'package:promina_task/features/login/domain/entity/response_entity.dart';
import 'package:promina_task/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitState()) {
    on<LoginButtonEvent>((event, emit) async {
      emit(state.copWith(
        status: RequestStatus.loading,
      ));
      var result = await loginUseCase.call(event.email, event.password);

      result.fold((l) {
        emit(state.copWith(
          status: RequestStatus.failure,
          failures: l,
        ));
      }, (r) {
        CacheHelper.saveData("token", r.token);
        emit(state.copWith(
          status: RequestStatus.success,
          entity: r,
        ));
      });
    });
  }
}
