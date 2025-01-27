// import 'package:flutter/material.dart';

// class MeetingProvider extends ChangeNotifier {
//   // final List<Map<String, String>> _meetings = [
//   //   {
//   //     'title': 'Design Team Meeting',
//   //     'date': '01/feb/2025',
//   //     'description': 'Lead by Reem Alhussaini on Burgan Lab',
//   //     'time': 'At 12:30 PM',
//   //   },
//   //   {
//   //     'title': 'Backend Planning Meeting',
//   //     'date': '01/feb/2025',
//   //     'description': 'Lead by Hussain Alsaffar on Burgan Lab',
//   //     'time': 'At 02:30 PM',
//   //   },
//   // ];

//   List<Map<String, String>> get meetings => _meetings;

//   void addMeeting(Map<String, String> meeting) {
//     _meetings.add(meeting);
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

class MeetingProvider extends ChangeNotifier {
  final List<Map<String, String>> _meetings = [];

  List<Map<String, String>> get meetings => _meetings;

  void addMeeting(Map<String, String> meeting) {
    _meetings.add(meeting);
    notifyListeners();
  }
}
