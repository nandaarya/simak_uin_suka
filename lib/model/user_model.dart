import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.password,
    required this.name,
    required this.role,
  });

  int id;
  dynamic password;
  String name;
  String role;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    password: json["password"],
    name: json["name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
    "name": name,
    "role": role,
  };
}