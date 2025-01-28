import 'package:flutter/material.dart';

class MeetingProvider extends ChangeNotifier {
  final List<Map<String, String>> _meetings = [];

  List<Map<String, String>> get meetings => _meetings;

  void addMeeting(Map<String, String> meeting) {
    _meetings.add(meeting);
    notifyListeners();
  }
}
