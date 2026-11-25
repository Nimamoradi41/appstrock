
import 'ModelFirstReportItem.dart';

class ModelLogItemReport {
  String name;
  String activity;
  String time;

  ModelLogItemReport({
    required this.name,
    required this.activity,
    required this.time,
  });

  factory ModelLogItemReport.fromJson(Map<String, dynamic> json) => ModelLogItemReport(
    name: json["name"]?? '',
    activity: json["activity"]?? '',
    time: json["time"]?? '',
  );

}