import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.nim,
  });

  String name;
  String email;
  dynamic nim;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    nim: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "nim": nim,
  };
}