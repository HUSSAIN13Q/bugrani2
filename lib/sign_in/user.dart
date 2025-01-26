class User {
  String name;
  String email;
  String password;
  String role;
  String? location;
  String? title;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.location,
    this.title,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        role = json['role'] as String,
        location = json['location'] as String?,
        title = json['title'] as String?;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'location': location,
      'title': title,
    };
  }
}
