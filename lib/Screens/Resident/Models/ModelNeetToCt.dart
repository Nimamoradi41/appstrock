// To parse this JSON data, do
//
//     final modelNeetToCt = modelNeetToCtFromJson(jsonString);

import 'dart:convert';

ModelNeetToCt modelNeetToCtFromJson(String str) => ModelNeetToCt.fromJson(json.decode(str));

String modelNeetToCtToJson(ModelNeetToCt data) => json.encode(data.toJson());

class ModelNeetToCt {
  dynamic data;
  bool success;
  String message;
  dynamic errors;

  ModelNeetToCt({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelNeetToCt.fromJson(Map<String, dynamic> json) => ModelNeetToCt(
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
