// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  Data? data;
  bool success;
  String message;
  dynamic errors;

  ModelLogin({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    data:  json["data"]!=null? Data.fromJson(json["data"]):
        Data(id: -1,departmentId: -1,isOnline: false,name: '',nationalCode: ''),
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
  int id;
  String name;
  String nationalCode;
  int departmentId;
  bool isOnline;

  Data({
    required this.id,
    required this.name,
    required this.nationalCode,
    required this.departmentId,
    required this.isOnline,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"]??'',
    name: json["name"]??'',
    nationalCode: json["nationalCode"]??'',
    departmentId: json["departmentId"]??'',
    isOnline: json["isOnline"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nationalCode": nationalCode,
    "departmentId": departmentId,
  };
}
