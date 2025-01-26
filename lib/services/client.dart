import 'package:dio/dio.dart';

const _baseUrl = 'http://localhost:8000';

// global variable
final Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));

class DioClient {
  static Future<Dio> getDio() async {
    final dio = Dio();
    // Add any additional configuration or interceptors if needed
    return dio;
  }
}
