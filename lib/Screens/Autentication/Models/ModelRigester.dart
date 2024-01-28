// To parse this JSON data, do
//
//     final modelRigester = modelRigesterFromJson(jsonString);

import 'dart:convert';

ModelRigester modelRigesterFromJson(String str) => ModelRigester.fromJson(json.decode(str));

String modelRigesterToJson(ModelRigester data) => json.encode(data.toJson());

class ModelRigester {
  Data data;
  bool success;
  String message;
  dynamic errors;

  ModelRigester({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelRigester.fromJson(Map<String, dynamic> json) => ModelRigester(
    data: Data.fromJson(json["data"]),
    success: json["success"],
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "success": success,
    "message": message,
    "errors": errors,
  };
}

class Data {
  int id;
  String name;
  String nationalCode;
  String mobileNumber;

  Data({
    required this.id,
    required this.name,
    required this.nationalCode,
    required this.mobileNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    nationalCode: json["nationalCode"],
    mobileNumber: json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nationalCode": nationalCode,
    "mobileNumber": mobileNumber,
  };
}
