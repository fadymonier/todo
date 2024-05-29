import 'package:dartz/dartz.dart';
import 'package:promina_task/core/errors/failures.dart';
import 'package:promina_task/features/login/domain/entity/response_entity.dart';

abstract class LoginRepo {
  Future<Either<Failures, ResponseEntity>> login(String email, String password);
}
