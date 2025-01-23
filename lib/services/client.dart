
import 'package:shared_preferences/shared_preferences.dart';

const _baseUrl = 'http://localhost:8000/';

// global variable
final Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));

class DioClient {
  static Future<Dio> getDio() async {
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return dio;
  }
}

