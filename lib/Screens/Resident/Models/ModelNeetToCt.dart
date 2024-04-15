// To parse this JSON data, do
//
//     final modelNeetToCt = modelNeetToCtFromJson(jsonString);

import 'dart:convert';

ModelNeetToCt modelNeetToCtFromJson(String str) => ModelNeetToCt.fromJson(json.decode(str));

String modelNeetToCtToJson(ModelNeetToCt data) => json.encode(data.toJson());

class ModelNeetToCt {
  bool success;
  String message;
  dynamic errors;

  ModelNeetToCt({
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelNeetToCt.fromJson(Map<String, dynamic> json) => ModelNeetToCt(
    success: json["success"]??false,
    message: json["message"]??'',
    errors: json["errors"]??false,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "errors": errors,
  };
}
