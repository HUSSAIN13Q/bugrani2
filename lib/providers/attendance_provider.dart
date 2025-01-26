import 'package:flutter/material.dart';
import '../services/attendance_service.dart';

class AttendanceProvider extends ChangeNotifier {
  final AttendanceService _attendanceService = AttendanceService();

  bool _isCheckedIn = false;
  bool _isLoading = false;
  String _statusMessage = '';
  String _checkInTime = '';
  String _checkOutTime = '';

  bool get isCheckedIn => _isCheckedIn;
  bool get isLoading => _isLoading;
  String get statusMessage => _statusMessage;
  String get checkInTime => _checkInTime;
  String get checkOutTime => _checkOutTime;

  Future<void> checkIn(double latitude, double longitude) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _attendanceService.checkIn(latitude, longitude);
      _isCheckedIn = true;
      _checkInTime = response['checkInTime'];
      _statusMessage = response['message'];
    } catch (e) {
      _statusMessage = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkOut(double latitude, double longitude) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _attendanceService.checkOut(latitude, longitude);
      _isCheckedIn = false;
      _checkOutTime = response['checkOutTime'];
      _statusMessage = response['message'];
    } catch (e) {
      _statusMessage = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
