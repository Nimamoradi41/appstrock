
import 'ModelFirstReportItem.dart';

class ModelFirstReportDate {
  int countPatient;
  int count724;
  int countInjection;
  final List<ModelFirstReportItem> medicinePatient;



  ModelFirstReportDate({
    required this.countPatient,
    required this.count724,
    required this.countInjection,
    required this.medicinePatient,

  });

  factory ModelFirstReportDate.fromJson(Map<String, dynamic> json) => ModelFirstReportDate(
    countPatient: json["countPatient"]?? 0,
    count724: json["count724"]?? 0,
    countInjection: json["countInjection"]?? 0,
    medicinePatient: json["medicinePatient"] == null ? [] : List<ModelFirstReportItem>.from(json["medicinePatient"]!.map((x) => ModelFirstReportItem.fromJson(x))),
  );

}