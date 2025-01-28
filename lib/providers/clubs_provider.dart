import 'package:bugrani2/models/club.dart';
import 'package:bugrani2/services/clubs_services.dart';
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
}
