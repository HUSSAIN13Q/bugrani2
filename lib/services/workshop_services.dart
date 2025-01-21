import 'package:dio/dio.dart';
import 'client.dart'; // Import your global Dio client

class WorkshopService {
  Future<Map<String, dynamic>> createWorkshop({
    required String title,
    required String date,
    required String description,
  }) async {
    try {
      Response response = await dio.post('/leaves', data: {
        'title': title,
        'date': date,
        'description': description,
      });
      return response.data;
    } on DioError catch (e) {
      return {'error': e.response?.data['message'] ?? 'Unknown error'};
    }
  }

  Future<Response> getWorkshop() async {
    try {
      Response response = await dio.get('/workshop');
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}