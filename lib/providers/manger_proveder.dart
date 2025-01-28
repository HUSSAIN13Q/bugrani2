// import 'package:bugrani2/services/mangaer_service.dart';
// import 'package:flutter/material.dart';

// class ManagerProvider extends ChangeNotifier {
//   final ManagerService _managerService = ManagerService();

//   bool _isLoading = false;
//   String _department = '';
//   int _totalEmployees = 0;
//   int _totalAbsentEmployees = 0;
//   List<Map<String, String>> _employees = [];
//   List<Map<String, String>> _absentEmployees = [];

//   bool get isLoading => _isLoading;
//   String get department => _department;
//   int get totalEmployees => _totalEmployees;
//   int get totalAbsentEmployees => _totalAbsentEmployees;
//   List<Map<String, String>> get employees => _employees;
//   List<Map<String, String>> get absentEmployees => _absentEmployees;

//   Future<void> fetchDepartmentEmployees() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _managerService.getDepartmentEmployees();
//       print('Full API Response: $response'); // Debugging

//       _department = response['department'] ?? '';
//       _totalEmployees = response['totalEmployees'] ?? 0;
//       _totalAbsentEmployees = response['totalAbsentEmployees'] ?? 0;

//       // Parse employees
//       _employees = (response['employees'] as List<dynamic>)
//           .map((e) => Map<String, String>.from(e as Map))
//           .toList();

//       _absentEmployees = (response['absentEmployees'] as List<dynamic>)
//           .map((e) => Map<String, String>.from(e as Map))
//           .toList();
//     } catch (e) {
//       print('Error fetching department employees: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
import 'package:bugrani2/services/mangaer_service.dart';
import 'package:flutter/material.dart';

class ManagerProvider extends ChangeNotifier {
  final ManagerService _managerService = ManagerService();

  bool _isLoading = false;
  String _department = '';
  int _totalEmployees = 0;
  int _totalAbsentEmployees = 0;
  List<Map<String, String>> _employees = [];
  List<Map<String, String>> _absentEmployees = [];

  bool get isLoading => _isLoading;
  String get department => _department;
  int get totalEmployees => _totalEmployees;
  int get totalAbsentEmployees => _totalAbsentEmployees;
  List<Map<String, String>> get employees => _employees;
  List<Map<String, String>> get absentEmployees => _absentEmployees;

  Future<void> fetchDepartmentEmployees() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _managerService.getDepartmentEmployees();
      print('Full API Response: $response'); // Debugging

      _department = response['department'] ?? '';
      _totalEmployees = response['totalEmployees'] ?? 0;
      _totalAbsentEmployees = response['totalAbsentEmployees'] ?? 0;

      // Parse employees
      _employees = (response['employees'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList();

      _absentEmployees = (response['absentEmployees'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList();
    } catch (e) {
      print('Error fetching department employees: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
