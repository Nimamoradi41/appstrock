

class ModelPatient {
  int id;
  String fullName;
  String nationalCode;
  String age;
  String gender;
  String timeOfAddToSystem;
  String dateOfAddToSystem;
  bool needToMRI;
  bool isNot724;
  bool needToCT;
  bool IsNIHSS;
  bool IsLab;

  ModelPatient({
    required this.id,
    required this.fullName,
    required this.nationalCode,
    required this.age,
    required this.gender,
    required this.timeOfAddToSystem,
    required this.dateOfAddToSystem,
    required this.needToMRI,
    required this.isNot724,
    required this.needToCT,
    required this.IsNIHSS,
    required this.IsLab,
  });

  factory ModelPatient.fromJson(Map<String, dynamic> json) => ModelPatient(
    id: json["id"],
    fullName: json["fullName"],
    nationalCode: json["nationalCode"],
    age: json["age"],
    gender: json["gender"],
    timeOfAddToSystem: json["timeOfAddToSystem"],
    dateOfAddToSystem: json["dateOfAddToSystem"],
    needToMRI: json["needToMRI"],
    isNot724: json["isNot724"],
    needToCT: json["needToCT"],
    IsNIHSS: json["IsNIHSS"],
    IsLab: json["IsLab"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "nationalCode": nationalCode,
    "age": age,
    "gender": gender,
    "timeOfAddToSystem": timeOfAddToSystem,
    "dateOfAddToSystem": dateOfAddToSystem,
    "needToMRI": needToMRI,
    "isNot724": isNot724,
    "needToCT": needToCT,
    "IsNIHSS": IsNIHSS,
    "IsLab": IsLab,
  };
}