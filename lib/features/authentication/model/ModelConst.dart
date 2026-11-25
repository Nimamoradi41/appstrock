// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelConst modelLoginFromJsonModelConst(String str) => ModelConst.fromJson(json.decode(str));

String modelLoginToJson(ModelConst data) => json.encode(data.toJson());

class ModelConst {
  bool success;
  String message;
  dynamic errors;

  ModelConst({
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelConst.fromJson(Map<String, dynamic> json) => ModelConst(
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
    id: json["id"],
    name: json["name"],
    nationalCode: json["nationalCode"],
    departmentId: json["departmentId"],
    isOnline: json["isOnline"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nationalCode": nationalCode,
    "departmentId": departmentId,
  };
}
