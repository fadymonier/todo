import 'package:dartz/dartz.dart';
import 'package:promina_task/core/errors/failures.dart';
import 'package:promina_task/features/login/data/data_source/remote/remote_login_ds.dart';
import 'package:promina_task/features/login/domain/entity/response_entity.dart';
import 'package:promina_task/features/login/domain/repository/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  RemoteLoginDS loginDS;

  LoginRepoImpl(this.loginDS);
  @override
  Future<Either<Failures, ResponseEntity>> login(
      String email, String password) async {
    try {
      var response = await loginDS.login(email, password);

      return Right(response);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }
}
