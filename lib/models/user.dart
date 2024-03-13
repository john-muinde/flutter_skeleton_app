class User {
  final String userId;
  final String email;
  final String name;
  final String token;
  final DateTime dateCreated;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.dateCreated,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      name: json['name'],
      dateCreated: DateTime.parse(json['date_created']),
      token: json['token'],
    );
  }

  User.empty()
      : userId = "",
        email = "",
        name = "",
        dateCreated = DateTime.now(),
        token = "";

  bool get empty =>
      userId == "" &&
      email == "" &&
      name == "" &&
      dateCreated == DateTime.now() &&
      token == "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['name'] = name;
    data['date_created'] = dateCreated.toIso8601String();
    data['token'] = token;
    return data;
  }
}
