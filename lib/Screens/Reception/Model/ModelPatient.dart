

class ModelPatient {
  int id;
  String fullName;
  String nationalCode;
  String age;
  String gender;
  String timeOfAddToSystem;
  String? timeOfAddLabotory;
  String? timeOfAddResident;
  String? TimeFss;
  String? TimeLKW;
  String? DateFSS;
  String? DateLKW;
  String? dateOfAddToSystem;
  String? dateOfAddToStart;
  String? ResonNot;
  String? Residents;
  String? Atends;
  String? Fesharkhon;
  String? Ghandkhon;
  bool needToMRI;
  bool isNot724;
  bool needToCT;
  bool? IsNIHSS;
  bool?  IsLab;
  bool?  IsUnknow;
  bool?  Is724;
  bool?  AddReasonNot724;
  bool?  AtendSeen;

  ModelPatient({
    required this.id,
    required this.fullName,
    required this.nationalCode,
    required this.age,
    required this.gender,
    required this.timeOfAddToSystem,
    required this.TimeFss,
    required this.TimeLKW,
    required this.DateFSS,
    required this.Atends,
    required this.Fesharkhon,
    required this.DateLKW,
    required this.IsUnknow,
    required this.timeOfAddLabotory,
    required this.Ghandkhon,
    required this.timeOfAddResident,
    required this.dateOfAddToSystem,
    required this.dateOfAddToStart,
    required this.ResonNot,
    required this.needToMRI,
    required this.Residents,
    required this.isNot724,
    required this.needToCT,
    required this.IsNIHSS,
    required this.IsLab,
    required this.Is724,
    required this.AddReasonNot724,
    required this.AtendSeen,
  });

  factory ModelPatient.fromJson(Map<String, dynamic> json) => ModelPatient(
    id: json["id"],
    fullName: json["fullName"],
    nationalCode: json["nationalCode"],
    age: json["age"],
    gender: json["gender"],
    timeOfAddToSystem: json["timeOfAddToSystem"],
    TimeFss: json["TimeFss"],
    Residents: json["Residents"],
    TimeLKW: json["TimeLKW"],
    DateFSS: json["DateFSS"],
    DateLKW: json["DateLKW"],
    IsUnknow: json["IsUnknow"],
    Atends: json["Atends"],
    Fesharkhon: json["Fesharkhon"],
    Ghandkhon: json["Ghandkhon"],
    dateOfAddToSystem: json["dateOfAddToSystem"],
    dateOfAddToStart: json["dateOfAddToStart"],
    timeOfAddResident: json["timeOfAddResident"],
    timeOfAddLabotory: json["timeOfAddLabotory"],
    ResonNot: json["ResonNot"],
    needToMRI: json["needToMRI"],
    isNot724: json["isNot724"],
    needToCT: json["needToCT"],
    IsNIHSS: json["IsNIHSS"],
    IsLab: json["IsLab"],
    Is724: json["Is724"],
    AddReasonNot724: json["AddReasonNot724"],
    AtendSeen: json["AtendSeen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "nationalCode": nationalCode,
    "age": age,
    "gender": gender,
    "timeOfAddToSystem": timeOfAddToSystem,
    "timeOfAddLabotory": timeOfAddLabotory,
    "dateOfAddToSystem": dateOfAddToSystem,
    "ResonNot": ResonNot,
    "needToMRI": needToMRI,
    "isNot724": isNot724,
    "needToCT": needToCT,
    "IsNIHSS": IsNIHSS,
    "IsLab": IsLab,
    "Is724": Is724,
  };
}