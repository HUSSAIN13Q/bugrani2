import 'dart:convert';
import 'package:dio/dio.dart';
import 'client.dart';
import 'package:bugrani2/sign_in/auth_services.dart';

class AttendanceService {
  final String baseUrl = "http://localhost:8000/attendance";

  // Method to check in
  Future<Map<String, dynamic>> checkIn(
      double latitude, double longitude) async {
    try {
      final dio = await DioClient.getDio();
      // Get the token from AuthServices
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final response = await dio.post(
        "$baseUrl/checkIn",
        data: json.encode({
          "latitude": latitude,
          "longitude": longitude,
        }),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 405) {
        return response.data;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      return e.response!.data;
    } catch (e) {
      throw Exception("Failed to check in: $e");
    }
  }

  // Method to check out
  Future<Map<String, dynamic>> checkOut(
      double latitude, double longitude) async {
    try {
      final dio = await DioClient.getDio();
      // Get the token from AuthServices
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final response = await dio.post(
        "$baseUrl/checkOut",
        data: json.encode({
          "latitude": latitude,
          "longitude": longitude,
        }),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 405) {
        return response.data;
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception("Failed to check out: $e");
    }
  }

  // Method to fetch today's attendance
  Future<Map<String, dynamic>?> getTodayAttendance() async {
    try {
      final dio = await DioClient.getDio();
      final response = await dio.get(
        "$baseUrl/today",
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      } else if (response.statusCode == 404) {
        // No attendance data for today
        return null;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        throw Exception(
            "Failed to fetch today's attendance: ${e.response?.data}");
      }
    } catch (e) {
      throw Exception("Failed to fetch today's attendance: $e");
    }
  }
}
