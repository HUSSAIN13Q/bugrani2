import 'package:bugrani2/models/leave.dart';
import 'package:bugrani2/models/workshop.dart';
import 'package:bugrani2/services/workshop_services.dart';
import 'package:bugrani2/services/leaves_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkshopProvider extends ChangeNotifier {
  List<Workshop> workshops = [];
  bool isLoading = false;

  // Fetch Workshop from the API
  Future<void> getWorkshop() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await WorkshopService().getWorkshop();
      workshops =
          (response.data as List).map((workshops) => Workshop.fromMap(workshops)).toList();
    } catch (e) {
      // Handle error
    }

    isLoading = false;
    notifyListeners();
  }

  // Submit a new leave request via the API
  Future<void> submitWorkshop({
    required String title,
    required String date,
    required String description,
  }) async {
    try {
      final response = await WorkshopService().createWorkshop(
        title: title,
        date: date,
        description: description,
      );

      // Add the newly created leave to the list
      workshops.add(Workshop.fromMap(response));
      notifyListeners();

      print("Submitted Leave Request Successfully");
    } catch (e) {
      print("Error submitting leave: $e");
    }
  }
}
