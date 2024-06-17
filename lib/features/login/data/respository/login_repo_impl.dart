import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/login/data/datasource/remote/remote_login_ds.dart';
import 'package:todo/features/login/data/models/login_response.dart';
import 'package:todo/features/login/domain/repository/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final RemoteLoginDS loginDS;
  LoginRepoImpl(this.loginDS);

  @override
  Future<Either<Failures, LoginResponse>> login(
      String email, String password) async {
    try {
      final response = await loginDS.login(email, password);

      return Right(response);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }
}
