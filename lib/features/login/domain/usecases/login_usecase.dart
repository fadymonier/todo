import 'package:dartz/dartz.dart';
import 'package:promina_task/core/errors/failures.dart';
import 'package:promina_task/features/login/domain/entity/response_entity.dart';
import 'package:promina_task/features/login/domain/repository/login_repo.dart';

class LoginUseCase {
  LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failures, ResponseEntity>> call(
          String email, String password) =>
      loginRepo.login(email, password);
}
