// To parse this JSON data, do
//
//     final modelListPatient = modelListPatientFromJson(jsonString);

import 'dart:convert';

import 'ModelPatient.dart';

ModelListPatient modelListPatientFromJson(String str) => ModelListPatient.fromJson(json.decode(str));

String modelListPatientToJson(ModelListPatient data) => json.encode(data.toJson());

class ModelListPatient {
  List<ModelPatient> data;
  bool success;
  dynamic message;
  dynamic errors;

  ModelListPatient({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelListPatient.fromJson(Map<String, dynamic> json) => ModelListPatient(
    data: List<ModelPatient>.from(json["data"].map((x) => ModelPatient.fromJson(x))),
    success: json["success"],
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "message": message,
    "errors": errors,
  };
}


