
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'client.dart'; // Import your global Dio client

class LeavesService {
  Future<Map<String, dynamic>> createLeave({
    required String type,
    required DateFormat startDate, // Now expecting string from the backend
    required DateFormat endDate, // Now expecting string from the backend
    required String description,
  }) async {
    try {
      final response = await dio.post(
        '/leaves', // Relative path, as the base URL is already set
        data: {
          "destination": type,
          "start_date": startDate,
          "end_date": endDate,
          "budget": description,
        },
      );
      print(response.statusCode);
      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Submitted Leave successfully: ${response.data}");
        return response.data;
      } else {
        throw Exception(
            "Failed to submit leave. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error submitting leave: $e");
      rethrow; // Forward the error to the caller
    }
  }

  Future<Response> getLeave() async {
    final response = await dio.get('/leaves');
    return response;
  }
}