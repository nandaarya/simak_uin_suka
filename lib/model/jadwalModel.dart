import 'dart:convert';

JadwalModel jadwalModelFromJson(String str) =>
    JadwalModel.fromJson(json.decode(str));

String jadwalModelToJson(JadwalModel data) => json.encode(data.toJson());

class JadwalModel {
  JadwalModel({
    required this.classCode,
    required this.className,
    required this.lecturer,
    required this.material,
    required this.startedAt,
    required this.finishAt,
    required this.room,
  });

  String classCode;
  String className;
  String lecturer;
  String material;
  String startedAt;
  String finishAt;
  String room;

  factory JadwalModel.fromJson(Map<String, dynamic> json) => JadwalModel(
    classCode: json["classCode"],
    className: json["className"],
    lecturer: json["lecturer"],
    material: json["material"],
    startedAt: json["startedAt"],
    finishAt: json["finishAt"],
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "classCode": classCode,
    "className": className,
    "lecturer": lecturer,
    "material": material,
    "startedAt": startedAt,
    "finishAt": finishAt,
    "room": room,
  };
}
