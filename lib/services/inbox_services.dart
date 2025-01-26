// import 'package:dio/dio.dart';
// import 'client.dart'; // Import your global Dio client

// class WorkshopService {
//   Future<Map<String, dynamic>> createWorkshop({
//     required String title,
//     required String date,
//     required String description,
//     required String created_by,
//   }) async {
//     try {
//       Response response = await dio.post('/workshop', data: {
//         'title': title,
//         'date': date,
//         'description': description,
//         'created_by': created_by
//       });
//       return response.data;
//     } on DioError catch (e) {
//       return {'error': e.response?.data['message'] ?? 'Unknown error'};
//     }
//   }

//   Future<Response> getWorkshop() async {
//     try {
//       Response response = await dio.get('/workshop');
//       return response;
//     } on DioError catch (e) {
//       return e.response!;
//     }
//   }
// }

import 'package:bugrani2/sign_in/auth_services.dart';
import 'package:dio/dio.dart';
import 'client.dart'; // Import your global Dio client

class MyWorkshopService {
  Future<Map<String, dynamic>> createMyWorkshop({
    required String title,
    required String date,
    required String description,
  }) async {
    try {
      Response response = await dio.post('/workshop/myworkshops', data: {
        'title': title,
        'date': date,
        'description': description,
      });
      return response.data;
    } on DioError catch (e) {
      return {'error': e.response?.data['message'] ?? 'Unknown error'};
    }
  }

  Future<Response> getMyWorkshop() async {
    // print('im here');
    try {
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      Response response = await dio.get(
        '/workshop/myworkshops',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
