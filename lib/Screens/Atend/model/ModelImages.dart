// To parse this JSON data, do
//
//     final modelImages = modelImagesFromJson(jsonString);

import 'dart:convert';

ModelImages modelImagesFromJson(String str) => ModelImages.fromJson(json.decode(str));

String modelImagesToJson(ModelImages data) => json.encode(data.toJson());

class ModelImages {
  List<ModelImageItem>? data;
  bool success;
  dynamic message;
  dynamic errors;

  ModelImages({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelImages.fromJson(Map<String, dynamic> json) => ModelImages(
    data:  json["data"]!=null?   List<ModelImageItem>.from(json["data"].map((x) => ModelImageItem.fromJson(x))):null,
    success: json["success"],
    message: json["message"] ,
    errors: json["errors"]??false,
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "message": message,
    "errors": errors,
  };
}

class ModelImageItem {
  int patientId;
  String patientName;
  int userId;
  String userName;
  String image;
  String insertDate;
  String insertTime;

  ModelImageItem({
    required this.patientId,
    required this.patientName,
    required this.userId,
    required this.userName,
    required this.image,
    required this.insertDate,
    required this.insertTime,
  });

  factory ModelImageItem.fromJson(Map<String, dynamic> json) => ModelImageItem(
    patientId: json["patientId"],
    patientName: json["patientName"],
    userId: json["userId"],
    userName: json["userName"],
    image: json["image"],
    insertDate: json["insertDate"],
    insertTime: json["insertTime"],
  );

  Map<String, dynamic> toJson() => {
    "patientId": patientId,
    "patientName": patientName,
    "userId": userId,
    "userName": userName,
    "image": image,
    "insertDate": insertDate,
    "insertTime": insertTime,
  };
}
