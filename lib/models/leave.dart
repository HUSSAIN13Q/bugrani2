import 'package:intl/intl.dart';

class Leave {
  final String id; // Add the id field
  final String type;
  final DateFormat startDate;
  final DateFormat endDate;
  final String description;
  

  Leave({
    required this.id, // Add the id field to the constructor
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.description,
    
  });

  factory Leave.fromMap(Map<String, dynamic> map) {
    return Leave(
      id: map['_id'], // Add the id field to the factory constructor
      type: map['type'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      description: map['description']
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Add the id field to the toMap method
      'destination': type,
      'start_date': startDate,
      'end_date': endDate,
      'budget': description,
      
    };
  }
}
