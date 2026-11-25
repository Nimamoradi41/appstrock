// To parse this JSON data, do
//
//     final modelOtpCode = modelOtpCodeFromJson(jsonString);

import 'dart:convert';

ModelOtpCode modelOtpCodeFromJson(String str) => ModelOtpCode.fromJson(json.decode(str));

String modelOtpCodeToJson(ModelOtpCode data) => json.encode(data.toJson());

class ModelOtpCode {
  dynamic data;
  bool success;
  String message;
  dynamic errors;

  ModelOtpCode({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelOtpCode.fromJson(Map<String, dynamic> json) => ModelOtpCode(
    // ignore: prefer_if_null_operators
    data: json['data'] != null ? json['data'] : null,
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
