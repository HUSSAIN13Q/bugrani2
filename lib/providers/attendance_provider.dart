import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bugrani2/services/attendance_service.dart';

class AttendanceProvider extends ChangeNotifier {
  final AttendanceService _attendanceService = AttendanceService();

  bool _isCheckedIn = false;
  bool _isLoading = false;
  bool _hasCheckedInToday = false;
  bool _hasCheckedOutToday = false;
  String _statusMessage = '';
  String _checkInTime = '';
  String _checkOutTime = '';
  double _workHours = 0.0;

  bool get isCheckedIn => _isCheckedIn;
  bool get isLoading => _isLoading;
  bool get hasCheckedInToday => _hasCheckedInToday;
  bool get hasCheckedOutToday => _hasCheckedOutToday;
  String get statusMessage => _statusMessage;
  String get checkInTime => _checkInTime;
  String get checkOutTime => _checkOutTime;
  double get workHours => _workHours;

  Future<void> checkIn(double latitude, double longitude) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _attendanceService.checkIn(latitude, longitude);
      _isCheckedIn = true;
      _checkInTime = response['attendance']['check_in_time'];
      _statusMessage = response['message'];
      _hasCheckedInToday = true;

      // Save to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('checkInTime', _checkInTime);
      await prefs.setBool('hasCheckedInToday', _hasCheckedInToday);
    } catch (e) {
      _statusMessage = "Check-In Error: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkOut(double latitude, double longitude) async {
    _isLoading = true;
    notifyListeners();

    if (!_hasCheckedInToday) {
      _statusMessage = "You need to check in before checking out.";
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await _attendanceService.checkOut(latitude, longitude);
      _isCheckedIn = false;
      _checkOutTime = response['attendance']['check_out_time'];
      _workHours = response['attendance']['work_hours'];
      _statusMessage = response['message'];
      _hasCheckedOutToday = true;

      // Save to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('checkOutTime', _checkOutTime);
      await prefs.setBool('hasCheckedOutToday', _hasCheckedOutToday);
      await prefs.setDouble('workHours', _workHours);
    } catch (e) {
      _statusMessage = "Check-Out Error: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAttendanceData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch today's attendance data
      final attendanceData = await _attendanceService.getTodayAttendance();

      if (attendanceData == null) {
        // Reset if no data exists for today
        await resetAttendanceData();
      } else {
        // Load data from the response
        _checkInTime = attendanceData['check_in_time'] ?? '';
        _checkOutTime = attendanceData['check_out_time'] ?? '';
        _workHours = attendanceData['work_hours'] ?? 0.0;
        _hasCheckedInToday = _checkInTime.isNotEmpty;
        _hasCheckedOutToday = _checkOutTime.isNotEmpty;
        _isCheckedIn = _hasCheckedInToday && !_hasCheckedOutToday;

        // Save to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('checkInTime', _checkInTime);
        await prefs.setString('checkOutTime', _checkOutTime);
        await prefs.setBool('hasCheckedInToday', _hasCheckedInToday);
        await prefs.setBool('hasCheckedOutToday', _hasCheckedOutToday);
        await prefs.setDouble('workHours', _workHours);
      }
    } catch (e) {
      _statusMessage = "Error loading attendance data: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetAttendanceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('checkInTime');
    await prefs.remove('checkOutTime');
    await prefs.remove('hasCheckedInToday');
    await prefs.remove('hasCheckedOutToday');
    await prefs.remove('workHours');

    _checkInTime = '';
    _checkOutTime = '';
    _workHours = 0.0;
    _hasCheckedInToday = false;
    _hasCheckedOutToday = false;
    _isCheckedIn = false;
    _statusMessage = '';
    notifyListeners();
  }
}