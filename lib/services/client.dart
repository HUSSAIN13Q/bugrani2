import 'package:dio/dio.dart';

const _baseUrl = 'http://localhost:8000';

final Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));

class DioClient {
  static Future<Dio> getDio() async {
    final dio = Dio();
    return dio;
  }
}
