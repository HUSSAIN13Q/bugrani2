import 'package:bugrani2/sign_in/auth_services.dart';
import 'package:dio/dio.dart';
import 'client.dart'; // Import your global Dio client

class WorkshopService {
  Future<Map<String, dynamic>> createWorkshop({
    required String title,
    required String date,
    required String description,
    required String created_by,
  }) async {
    try {
      Response response = await dio.post('/workshop', data: {
        'title': title,
        'date': date,
        'description': description,
        'created_by': created_by
      });
      return response.data;
    } on DioError catch (e) {
      return {'error': e.response?.data['message'] ?? 'Unknown error'};
    }
  }

  Future<Response> getWorkshop() async {
    print('im here');
    try {
      Response response = await dio.get(
        '/workshop',
      );
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Map<String, dynamic>> applyForWorkshop(String workshopId) async {
    try {
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      Response response = await dio.post(
        '/workshop/$workshopId/apply',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return {'error': e.response?.data['message'] ?? 'Unknown error'};
    }
  }
}
