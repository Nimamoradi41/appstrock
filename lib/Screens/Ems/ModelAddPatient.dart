// To parse this JSON data, do
//
//     final modelAddPatient = modelAddPatientFromJson(jsonString);

import 'dart:convert';

ModelAddPatient modelAddPatientFromJson(String str) => ModelAddPatient.fromJson(json.decode(str));

String modelAddPatientToJson(ModelAddPatient data) => json.encode(data.toJson());

class ModelAddPatient {
  bool data;
  bool success;
  String message;
  dynamic errors;

  ModelAddPatient({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelAddPatient.fromJson(Map<String, dynamic> json) => ModelAddPatient(
    data: json["data"],
    success: json["success"],
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "success": success,
    "message": message,
    "errors": errors,
  };
}
