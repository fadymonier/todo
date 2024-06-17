import 'package:todo/core/api/api_manager.dart';
import 'package:todo/core/api/endpoints.dart';
import 'package:todo/features/login/data/datasource/remote/remote_login_ds.dart';
import 'package:todo/features/login/data/models/login_response.dart';

class RemoteLoginDSImpl implements RemoteLoginDS {
  @override
  Future<LoginResponse> login(String email, String password) async {
    ApiManager apiManager = ApiManager();

    var response = await apiManager.postData(
      endPoint: EndPoints.login,
      body: {"username": email, "password": password},
    );
    return LoginResponse.fromJson(response.data);
  }
}
