class Club {
  final String id; // Add the id field
  final String title;
  final String description;
  //final String created_by;

  Club({
    required this.id, // Add the id field to the constructor
    required this.title,
    required this.description,
    //required this.created_by,
  });

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
        id: map['_id'], // Add the id field to the factory constructor
        title: map['title'],
        description: map['description']);
    // created_by: map['created_by']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Add the id field to the toMap method
      'title': title,
      'description': description,
      // 'created_by': created_by
    };
  }
}
