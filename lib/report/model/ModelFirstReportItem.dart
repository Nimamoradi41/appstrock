
class ModelFirstReportItem {
  int patientId;
  String patientName;
  int medicine;



  ModelFirstReportItem({
    required this.patientId,
    required this.patientName,
    required this.medicine,
  });

  factory ModelFirstReportItem.fromJson(Map<String, dynamic> json) => ModelFirstReportItem(
    patientId: json["patientId"]?? 0,
    patientName: json["patientName"]?? '',
    medicine: json["medicine"]?? 0,

  );

  Map<String, dynamic> toJson() => {
    "id": patientId,
    "patientName": patientName,
    "medicine": medicine,

  };
}