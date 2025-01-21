import 'package:bugrani2/models/leave.dart';
import 'package:bugrani2/services/leaves_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeavesProvider extends ChangeNotifier {
  List<Leave> leaves = [];
  bool isLoading = false;

  // Fetch Leaves from the API
  Future<void> getLeaves() async {
    try {
      isLoading = true;
      //notifyListeners();

      // Call the TripService to fetch trips
      final response = await LeavesService().getLeave();

      // Assuming response.data contains a list of trips
      if (response.statusCode == 200 && response.data != null) {
        print("Response: ${response.data}");

        leaves = (response.data as List)
            .map((leaveData) => Leave.fromMap(leaveData))
            .toList();

        // print("Trips fetched successfully: ${destinations}");
      }
    } catch (e) {
      print("Error fetching trips: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Create a new trip via the API
  Future<void> createTrip({
    required String type,
    required DateFormat startDate,
    required DateFormat endDate,
    required String description,
  }) async {
    try {
      final response = await LeavesService().createLeave(
        type: type,
        startDate: startDate,
        endDate: endDate,
        description: description,
      );

      // Add the newly created trip to the list
      leaves.add(Leave.fromMap(response));
      notifyListeners();

      print("Sumbitted Leave Request Successfully");
    } catch (e) {
      print("Error sumbitting leave: $e");
    }
  }
}
