
import 'dart:convert';

import 'ModelFirstReportDate.dart';
import 'ModelFirstReportItem.dart';

ModelFirstReport modelReportFromJson(String str) => ModelFirstReport.fromJson(json.decode(str));

class ModelFirstReport {
  ModelFirstReportDate? data;
  bool success;
  String? message;
  bool? errors;

  ModelFirstReport({
    required this.data,
    required this.success,
    required this.message,
    required this.errors,
  });

  factory ModelFirstReport.fromJson(Map<String, dynamic> json) => ModelFirstReport(
    data: json["data"] == null ? null : ModelFirstReportDate.fromJson(json["data"]),
    success: json["success"]??false,
    message: json["message"]??'',
    errors: json["errors"]??false,
  );
}