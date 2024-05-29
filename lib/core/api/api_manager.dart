import 'package:dio/dio.dart';
import 'package:promina_task/core/utils/constants.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio();
  }

  Future<Response> getData(
      {required String endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParam}) {
    return dio.get(AppConstants.baseURL + endPoint,
        queryParameters: queryParam, options: Options(headers: headers));
  }

  Future<Response> postData(
      {required String endPoint, Map<String, dynamic>? body}) {
    return dio.post(AppConstants.baseURL + endPoint, data: body);
  }
}
