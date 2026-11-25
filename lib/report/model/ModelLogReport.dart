
import 'dart:convert';

import 'ModelFirstReportDate.dart';
import 'ModelFirstReportItem.dart';
import 'ModelLogItemReport.dart';

ModelLogReport modelReportLogFromJson(String str) => ModelLogReport.fromJson(json.decode(str));

class ModelLogReport {
  List<ModelLogItemReport>? data;
  bool success;
  String? message;
  bool? errors;

  ModelLogReport({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelLogReport.fromJson(Map<String, dynamic> json) => ModelLogReport(
    data: json["data"] == null ? [] : List<ModelLogItemReport>.from(json["data"]!.map((x) => ModelLogItemReport.fromJson(x))),
    success: json["success"]??false,
    message: json["message"]??'',
    errors: json["errors"]??false,
  );
}