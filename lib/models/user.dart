import 'dart:convert';

class User {
  String id;
  String name;
  String email;
  String description;
  String avatar;
  String? token;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.description,
      required this.avatar,
      this.token});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'description': description,
      'avatar': avatar,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      description: map['description'] as String,
      avatar: map['avatar'] as String,
      token: map['token'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
