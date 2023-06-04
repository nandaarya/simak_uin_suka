import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.nim_nip,
    required this.role,
  });

  String username;
  String password;
  String email;
  String name;
  String nim_nip;
  String role;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    password: json["password"],
    email: json["email"],
    name: json["name"],
    nim_nip: json["nim_nip"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
    "name": name,
    "nim_nip": nim_nip,
    "role": role,
  };
}