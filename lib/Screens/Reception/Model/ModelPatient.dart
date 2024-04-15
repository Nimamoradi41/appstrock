

class ModelPatient {
  int id;
  String fullName;
  String nationalCode;
  String age;
  String gender;
  String timeOfAddToSystem;
  String? timeOfAddLabotory;
  String? signsStartTime;
  String? signsStartDate;
  String? fssTime;
  String? lkwTime;
  String? fssDate;
  String? lkwDate;
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
  bool? nihsIsComplete;
  bool?  IsLab;
  bool?  is724IsComplete;
  bool?  AddReasonNot724;
  bool?  AtendSeen;
  bool?  signsStartIsUnknown;

  ModelPatient({
    required this.id,
    required this.fullName,
    required this.nationalCode,
    required this.age,
    required this.gender,
    required this.timeOfAddToSystem,
    required this.signsStartTime,
    required this.signsStartDate,
    required this.dateOfAddToSystem,
    required this.dateOfAddToStart,
    required this.timeOfAddLabotory,
    required this.Ghandkhon,
    required this.fssTime,
    required this.lkwTime,
    required this.fssDate,
    required this.Atends,
    required this.Fesharkhon,
    required this.lkwDate,

    required this.ResonNot,
    required this.needToMRI,
    required this.Residents,
    required this.isNot724,
    required this.needToCT,
    required this.nihsIsComplete,
    required this.IsLab,
    required this.is724IsComplete,
    required this.AddReasonNot724,
    required this.AtendSeen,
    required this.signsStartIsUnknown,
  });

  factory ModelPatient.fromJson(Map<String, dynamic> json) => ModelPatient(
    id: json["id"]?? '',
    fullName: json["fullName"]?? '',
    nationalCode: json["nationalCode"]?? '',
    age: json["age"]?? '',
    gender: json["gender"]?? '',
    timeOfAddToSystem: json["timeOfAddToSystem"]?? '',
    fssTime: json["fssTime"]?? '',
    signsStartDate: json["signsStartDate"]?? '',
    Residents: json["Residents"]?? '',
    lkwTime: json["lkwTime"]?? '',
    fssDate: json["fssDate"]?? '',
    lkwDate: json["lkwDate"]?? '',

    Atends: json["Atends"]?? '',
    Fesharkhon: json["Fesharkhon"]?? '',
    Ghandkhon: json["Ghandkhon"]?? '',
    dateOfAddToSystem: json["dateOfAddToSystem"]?? '',
    dateOfAddToStart: json["dateOfAddToStart"]?? '',
    signsStartTime: json["signsStartTime"]?? '',
    timeOfAddLabotory: json["timeOfAddLabotory"]?? '',
    ResonNot: json["ResonNot"]??'',
    needToMRI: json["needToMRI"]??false,
    isNot724: json["isNot724"]??false,
    needToCT: json["needToCT"]??false,
    nihsIsComplete: json["nihsIsComplete"],
    IsLab: json["IsLab"]??false,
    is724IsComplete: json["is724IsComplete"]??false,
    AddReasonNot724: json["AddReasonNot724"]??false,
    AtendSeen: json["AtendSeen"]??false,
    signsStartIsUnknown: json["signsStartIsUnknown"]??false,
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
    "signsStartIsUnknown": signsStartIsUnknown,
    "needToMRI": needToMRI,
    "isNot724": isNot724,
    "needToCT": needToCT,
    "IsNIHSS": nihsIsComplete,
    "IsLab": IsLab,
    "Is724": is724IsComplete,
    "dateOfAddToSystem": dateOfAddToSystem,
  };
}