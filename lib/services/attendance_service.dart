import 'dart:convert';
import 'package:dio/dio.dart';
import 'client.dart';

class AttendanceService {
  final String baseUrl = "http://localhost:8000/attendance";

  Future<Map<String, dynamic>> checkIn(double latitude, double longitude) async {
    try {
      final dio = await DioClient.getDio();
      final response = await dio.post(
        "$baseUrl/checkIn",
        data: json.encode({
          "latitude": latitude,
          "longitude": longitude,
        }),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception("Failed to check in: $e");
    }
  }

  Future<Map<String, dynamic>> checkOut(double latitude, double longitude) async {
    try {
      final dio = await DioClient.getDio();
      final response = await dio.post(
        "$baseUrl/checkOut",
        data: json.encode({
          "latitude": latitude,
          "longitude": longitude,
        }),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception("Failed to check out: $e");
    }
  }
}
