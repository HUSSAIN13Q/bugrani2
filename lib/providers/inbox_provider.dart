import 'package:bugrani2/models/inbox.dart';
import 'package:bugrani2/services/inbox_services.dart';
import 'package:flutter/material.dart';

class MyWorkshopProvider extends ChangeNotifier {
  List<MyWorkshop> myworkshops = [];
  bool isLoading = false;
  String? errorMessage;

  // Fetch Workshop from the API
  Future<void> getMyWorkshop() async {
    print("i reached the provider");
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await MyWorkshopService().getMyWorkshop();
      print("API Response: ${response.data}");
      myworkshops = (response.data as List)
          .map((myworkshops) => MyWorkshop.fromMap(myworkshops))
          .toList();
      print("Mapped Workshops: $myworkshops");
    } catch (e) {
      print(e);
      errorMessage = 'Failed to load myworkshops. Please try again later.';
    }

    isLoading = false;
    notifyListeners();
  }
}
