class User {
  String username;
  String token;

  User({required this.username, required this.token});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String,
        token = json['token'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'username': username, 'password': token};
  }
}
