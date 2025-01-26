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

import 'package:bugrani2/sign_in/auth_services.dart';
import 'package:dio/dio.dart';
import 'client.dart'; // Import your global Dio client

class ClubsService {
  // Future<Map<String, dynamic>> createClub({
  //   required String title,
  //   required String description,
  // }) async {
  //   try {
  //     Response response = await dio.post('/community', data: {
  //       'title': title,
  //       'description': description,
  //     });
  //     return response.data;
  //   } on DioError catch (e) {
  //     return {'error': e.response?.data['message'] ?? 'Unknown error'};
  //   }
  // }

  Future<Response> getClubs() async {
    print('im in the clubs services :)');
    try {
      Response response = await dio.get(
        '/community',
      );
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Map<String, dynamic>> applyForClub(String clubId) async {
    try {
      String? token = await AuthServices().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      Response response = await dio.post(
        '/community/$clubId/apply',
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
