import 'dart:convert';

PresensiModel presensiModelFromJson(String str) =>
    PresensiModel.fromJson(json.decode(str));

String presensiModelToJson(PresensiModel data) => json.encode(data.toJson());

class PresensiModel {
  PresensiModel({
    required this.nim,
    required this.classCode,
    required this.status,
  });

  String nim;
  String classCode;
  String status;

  factory PresensiModel.fromJson(Map<String, dynamic> json) => PresensiModel(
    nim: json["nim"],
    classCode: json["classCode"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "nim": nim,
    "classCode": classCode,
    "status": status,
  };
}
