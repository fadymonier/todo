import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/login/data/models/login_response.dart';

abstract class LoginRepo {
  Future<Either<Failures, LoginResponse>> login(String email, String password);
}
