class Attendance {
  final String userId;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String date;
  final double? workHours;
  final double? lateHours;
  final Location location;

  Attendance({
    required this.userId,
    this.checkInTime,
    this.checkOutTime,
    required this.date,
    this.workHours,
    this.lateHours,
    required this.location,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      userId: json['user_id'],
      checkInTime: json['check_in_time'] != null ? DateTime.parse(json['check_in_time']) : null,
      checkOutTime: json['check_out_time'] != null ? DateTime.parse(json['check_out_time']) : null,
      date: json['date'],
      workHours: json['work_hours']?.toDouble(),
      lateHours: json['late_hours']?.toDouble(),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'check_in_time': checkInTime?.toIso8601String(),
      'check_out_time': checkOutTime?.toIso8601String(),
      'date': date,
      'work_hours': workHours,
      'late_hours': lateHours,
      'location': location.toJson(),
    };
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
