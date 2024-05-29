import 'package:promina_task/core/api/api_manager.dart';
import 'package:promina_task/core/api/endpoints.dart';
import 'package:promina_task/features/login/data/data_source/remote/remote_login_ds.dart';
import 'package:promina_task/features/login/data/models/user_model.dart';

class RemoteLoginDSImpl implements RemoteLoginDS {
  @override
  Future<UserModel> login(String email, String password) async {
    ApiManager apiManager = ApiManager();
    var response = await apiManager.postData(
        endPoint: EndPoints.login,
        body: {"email": email, "password": password});

    UserModel userModel = UserModel.fromJson(response.data);
    return userModel;
  }
}
