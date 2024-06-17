import 'package:dio/dio.dart';
import 'package:todo/core/api/endpoints.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio();
  }

  Future<Response> getData(
      {required String endPint, Map<String, dynamic>? queryParam}) {
    return dio.get(EndPoints.login, queryParameters: queryParam);
  }

  Future<Response> postData(
      {required String endPoint, Map<String, dynamic>? body}) {
    return dio.post(EndPoints.login, data: body);
  }
}
