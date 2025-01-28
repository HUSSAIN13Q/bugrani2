class User {
  String? id;

  String? name;
  String email;
  String password;
  String role;
  String? location;
  String? title;
  String? department;

  User({
    this.id,
    this.name,
    required this.email,
    required this.password,
    required this.role,
    this.location,
    this.title,
    this.department,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        email = json['email'] as String,
        password = json['password'] as String,
        role = json['role'] as String,
        location = json['location'] as String?,
        title = json['title'] as String?,
        department = json['department'] as String?;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'location': location,
      'title': title,
      "department": department,
    };
  }
}
