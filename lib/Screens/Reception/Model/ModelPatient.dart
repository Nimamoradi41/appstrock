

class ModelPatient {
  int id;
  String fullName;
  String nationalCode;
  String age;
  String gender;

  ModelPatient({
    required this.id,
    required this.fullName,
    required this.nationalCode,
    required this.age,
    required this.gender,
  });

  factory ModelPatient.fromJson(Map<String, dynamic> json) => ModelPatient(
    id: json["id"],
    fullName: json["fullName"],
    nationalCode: json["nationalCode"],
    age: json["age"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "nationalCode": nationalCode,
    "age": age,
    "gender": gender,
  };
}