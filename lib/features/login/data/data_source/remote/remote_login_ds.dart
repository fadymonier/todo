import 'package:promina_task/features/login/data/models/user_model.dart';

abstract class RemoteLoginDS {
  Future<UserModel> login(String email, String password);
}
