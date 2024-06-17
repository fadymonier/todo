import 'package:todo/features/login/data/models/login_response.dart';

abstract class RemoteLoginDS {
  Future<LoginResponse> login(String email, String password);
}
