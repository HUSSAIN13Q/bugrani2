import 'package:dio/dio.dart';
import 'client.dart';
import 'package:bugrani2/sign_in/auth_services.dart';

class ManagerService {
  final String baseUrl = "http://localhost:8000";
  final AuthServices _authServices = AuthServices();

  Future<Map<String, dynamic>> getDepartmentEmployees() async {
    try {
      final dio = await DioClient.getDio();
      String? token = await _authServices.getToken();

      if (token == null) {
        throw Exception('Not authorized - No token found');
      }

      final response = await dio.get(
        '$baseUrl/auth/department-employees',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Not authorized');
      }
      throw Exception('Failed to fetch department employees: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getEmployeeInsights(String employeeId) async {
    try {
      final dio = await DioClient.getDio();
      String? token = await _authServices.getToken();

      if (token == null) {
        throw Exception('Not authorized - No token found');
      }

      final response = await dio.get(
        '$baseUrl/leaves/insights/$employeeId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Not authorized');
      }
      throw Exception('Failed to fetch employee insights: ${e.message}');
    }
  }
}
