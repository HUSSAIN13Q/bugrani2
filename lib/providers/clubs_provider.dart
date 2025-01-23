// import 'package:bugrani2/models/workshop.dart';
// import 'package:bugrani2/services/workshop_services.dart';
// import 'package:flutter/material.dart';

// class WorkshopProvider extends ChangeNotifier {
//   List<Workshop> workshops = [];
//   bool isLoading = false;

//   // Fetch Workshop from the API
//   Future<void> getWorkshop() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final response = await WorkshopService().getWorkshop();
//       workshops = (response.data as List)
//           .map((workshops) => Workshop.fromMap(workshops))
//           .toList();
//     } catch (e) {
//       // Handle error
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   // Submit a new leave request via the API
//   Future<void> submitWorkshop(
//       {required String title,
//       required String date,
//       required String description,
//       required String created_by}) async {
//     try {
//       final response = await WorkshopService().createWorkshop(
//           title: title,
//           date: date,
//           description: description,
//           created_by: created_by);

//       // Add the newly created leave to the list
//       workshops.add(Workshop.fromMap(response));
//       notifyListeners();

//       print("Submitted Leave Request Successfully");
//     } catch (e) {
//       print("Error submitting leave: $e");
//     }
//   }
// }

import 'package:bugrani2/models/club.dart';
import 'package:bugrani2/models/workshop.dart';
import 'package:bugrani2/services/clubs_services.dart';
import 'package:bugrani2/services/workshop_services.dart';
import 'package:flutter/material.dart';

class ClubsProvider extends ChangeNotifier {
  List<Club> clubs = [];
  bool isLoading = false;
  String? errorMessage;

  // Fetch Workshop from the API
  Future<void> getClubs() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await ClubsService().getClubs();
      clubs = (response.data['communities'] as List)
          .map((clubs) => Club.fromMap(clubs))
          .toList();
    } catch (e) {
      print(e);
      errorMessage = 'Failed to load clubs. Please try again later.';
    }

    isLoading = false;
    notifyListeners();
  }

  // Submit a new workshop via the API
  // Future<void> createClubs({
  //   required String title,
  //   required String description,
  // }) async {
  //   try {
  //     final response = await ClubsService().createClub(
  //       title: title,
  //       description: description,
  //     );

  //     // Add the newly created workshop to the list
  //     clubs.add(Club.fromMap(response));
  //     notifyListeners();

  //     print("Submitted Workshop Successfully");
  //   } catch (e) {
  //     errorMessage = 'Failed to submit workshop. Please try again later.';
  //     notifyListeners();
  //   }
}
