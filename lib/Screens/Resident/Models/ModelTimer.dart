// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelTimer modelTimerFromJson(String str) => ModelTimer.fromJson(json.decode(str));

String modelTimerToJson(ModelTimer data) => json.encode(data.toJson());

class ModelTimer {
  Data? data;
  bool success;
  String message;
  dynamic errors;

  ModelTimer({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelTimer.fromJson(Map<String, dynamic> json) => ModelTimer(
    data:  json["data"]!=null? Data.fromJson(json["data"]):
    Data(shamsi: '', miladi: '', timeStamp: 0),
    success: json["success"]??false,
    message: json["message"]??'',
    errors: json["errors"]??false,
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "success": success,
    "message": message,
    "errors": errors,
  };
}

class Data {
  String shamsi;
  String miladi;
  int timeStamp;

  Data({
    required this.shamsi,
    required this.miladi,
    required this.timeStamp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    shamsi: json["shamsi"]??'',
    miladi: json["miladi"]??'',
    timeStamp: json["timeStamp"]??0,
  );

  Map<String, dynamic> toJson() => {
    "shamsi": shamsi,
    "miladi": miladi,
    "timeStamp": timeStamp,
  };
}
