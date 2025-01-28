class Leave {
  String id;
  String userId;
  String userName;
  String type;
  String startDate;
  String endDate;
  String description;
  String status;

  Leave({
    required this.id,
    required this.userId,
    required this.userName,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.status,
  });

  factory Leave.fromMap(Map<String, dynamic> map) {
    return Leave(
      id: map['_id'],
      userId: map['user_id']['_id'],
      userName: map['user_id']['name'],
      type: map['type'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      description: map['description'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user_id': {
        '_id': userId,
        'name': userName,
      },
      'type': type,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
      'status': status,
    };
  }

  set setStatus(String newStatus) {
    status = newStatus;
  }
}
