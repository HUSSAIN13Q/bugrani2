import 'package:dio/dio.dart';
import 'package:bugrani2/sign_in/auth_services.dart';
import 'client.dart'; // Import your global Dio client

class LeavesService {
  Future<Map<String, dynamic>> createLeave({
    required String type,
    required String startDate,
    required String endDate,
    required String description,
  }) async {
    try {
      Response response = await dio.post('/leaves', data: {
        'type': type,
        'start_date': startDate,
        'end_date': endDate,
        'description': description,
      });
      return response.data;
    } on DioError catch (e) {
      return {'error': e.response?.data['message'] ?? 'Unknown error'};
    }
  }

  Future<Response> getLeaves() async {
    try {
      Response response = await dio.get('/leaves/all');
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<void> approveLeave(String leaveId) async {
    try {
      await dio.patch('/leaves/$leaveId/approve');
    } on DioError catch (e) {
      throw Exception(
          'Error approving leave: ${e.response?.data['message'] ?? 'Unknown error'}');
    }
  }

  Future<void> rejectLeave(String leaveId) async {
    try {
      await dio.patch('/leaves/$leaveId/reject');
    } on DioError catch (e) {
      throw Exception(
          'Error rejecting leave: ${e.response?.data['message'] ?? 'Unknown error'}');
    }
  }

  Future<Response> getLeaveBalance() async {
    try {
      // Get the token from AuthServices
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      Response response = await dio.get(
        '/leaves/leaveBalance',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> getLeaveRecommendations() async {
    try {
      // Get the token from AuthServices
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      Response response = await dio.get(
        '/leaves/recommendation',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> getMyLeave() async {
    try {
      // Get the token from AuthServices
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      Response response = await dio.get(
        '/leaves',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
