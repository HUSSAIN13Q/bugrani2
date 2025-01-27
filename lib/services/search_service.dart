import 'package:bugrani2/sign_in/auth_services.dart';
import 'package:dio/dio.dart';

import 'client.dart';
// Import the Dio client

class SearchService {
  final Dio _dio = dio; // Use the global Dio client

  Future<List<dynamic>> searchEmployees(String query) async {
    try {
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final response = await _dio.get(
        '/auth/search',
        queryParameters: {'name': query},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data['employees'];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
