class MyWorkshop {
  final String id; // Add the id field
  final String title;
  final String date;
  final String description;
  //final String created_by;

  MyWorkshop({
    required this.id, // Add the id field to the constructor
    required this.title,
    required this.date,
    required this.description,
    //required this.created_by,
  });

  factory MyWorkshop.fromMap(Map<String, dynamic> map) {
    return MyWorkshop(
        id: map['_id'], // Add the id field to the factory constructor
        title: map['title'],
        date: map['date'],
        description: map['description']);
    // created_by: map['created_by']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Add the id field to the toMap method
      'title': title,
      'date': date,
      'description': description,
      // 'created_by': created_by
    };
  }
}
