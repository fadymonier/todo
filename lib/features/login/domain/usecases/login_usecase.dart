import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/login/data/models/login_response.dart';
import 'package:todo/features/login/domain/repository/login_repo.dart';

class LoginUseCase {
  LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failures, LoginResponse>> call(String email, String password) =>
      loginRepo.login(email, password);
}
