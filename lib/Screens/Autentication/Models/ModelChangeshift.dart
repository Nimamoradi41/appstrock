// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelChangeshift modelLoginFromJsonModelChangeshift(String str) => ModelChangeshift.fromJson(json.decode(str));

String modelLoginToJson(ModelChangeshift data) => json.encode(data.toJson());

class ModelChangeshift {
  DataModelChangeshift? data;
  bool success;
  String message;
  dynamic errors;

  ModelChangeshift({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelChangeshift.fromJson(Map<String, dynamic> json) => ModelChangeshift(
    data:  json["data"]!=null? DataModelChangeshift.fromJson(json["data"]):
    DataModelChangeshift(id: -1,isOnline: false,userName: '',nationalCode: ''),
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

class DataModelChangeshift {
  int id;
  String userName;
  String nationalCode;
  bool isOnline;

  DataModelChangeshift({
    required this.id,
    required this.userName,
    required this.nationalCode,
    required this.isOnline,
  });

  factory DataModelChangeshift.fromJson(Map<String, dynamic> json) => DataModelChangeshift(
    id: json["id"]??'',
    userName: json["userName"]??'',
    nationalCode: json["nationalCode"]??'',
    isOnline: json["isOnline"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "nationalCode": nationalCode,

  };
}
