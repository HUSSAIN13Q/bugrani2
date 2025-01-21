class Workshop {
  final String id; // Add the id field
  final String title;
  final String date;
  final String description;

  Workshop({
    required this.id, // Add the id field to the constructor
    required this.title,
    required this.date,
    required this.description,
  });

  factory Workshop.fromMap(Map<String, dynamic> map) {
    return Workshop(
      id: map['workshop']['_id'], // Add the id field to the factory constructor
      title: map['workshop']['title'],
      date: map['workshop']['date'],
      description: map['workshop']['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Add the id field to the toMap method
      'title': title,
      'date': date,
      'description': description,
    };
  }
}
