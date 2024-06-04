

class ModelPatient {
  int id;
  String fullName;
  String nationalCode;
  String age;
  String gender;
  String timeOfAddToSystem;
  String? timeOfAddLabotory;
  String? TimeOfInjection;
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
  bool?  labIsComplete;
  bool?  is724IsComplete;
  bool?  AddReasonNot724;
  bool?  AtendSeen;
  bool?  signsStartIsUnknown;
  String?  n_1_a;
  String?  n_1_b;
  String?  n_1_c;
  String?  n_2;
  String?  n_3;
  String?  n_4;
  String?  n_5_a;
  String?  n_5_b;
  String?  n_6_a;
  String?  n_6_b;
  String?  n_7;
  String?  n_8;
  String?  n_9;
  String?  n_10;
  String?  n_11;
  String?  bun;
  String?  cr;
  String?  plt;
  String?  pt;
  String?  ptt;
  String?  inr;
  bool?  trop;


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
    required this.labIsComplete,
    required this.is724IsComplete,
    required this.AddReasonNot724,
    required this.AtendSeen,
    required this.signsStartIsUnknown,
    required this.TimeOfInjection,
    required this.n_1_a,
    required this.n_1_b,
    required this.n_1_c,
    required this.n_2,
    required this.n_3,
    required this.n_4,
    required this.n_5_a,
    required this.n_5_b,
    required this.n_6_a,
    required this.n_6_b,
    required this.n_7,
    required this.n_8,
    required this.n_9,
    required this.n_10,
    required this.n_11,
    required this.bun,
    required this.cr,
    required this.plt,
    required this.pt,
    required this.ptt,
    required this.inr,
    required this.trop,
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
    TimeOfInjection: json["TimeOfInjection"]?? '',
    ResonNot: json["ResonNot"]??'',
    needToMRI: json["needToMRI"]??false,
    isNot724: json["isNot724"]??false,
    needToCT: json["needToCT"]??false,
    nihsIsComplete: json["nihsIsComplete"]??false,
    labIsComplete: json["labIsComplete"]??false,
    is724IsComplete: json["is724IsComplete"]??false,
    AddReasonNot724: json["AddReasonNot724"]??false,
    AtendSeen: json["AtendSeen"]??false,
    signsStartIsUnknown: json["signsStartIsUnknown"]??false,
    n_1_a: json["n_1_a"]??'',
    n_1_b: json["n_1_b"]??'',
    n_1_c: json["n_1_c"]??'',
    n_2: json["n_2"]??'',
    n_3: json["n_3"]??'',
    n_4: json["n_4"]??'',
    n_5_a: json["n_5_a"]??'',
    n_5_b: json["n_5_b"]??'',
    n_6_a: json["n_6_a"]??'',
    n_6_b: json["n_6_b"]??'',
    n_7: json["n_7"]??'',
    n_8: json["n_8"]??'',
    n_9: json["n_9"]??'',
    n_10: json["n_10"]??'',
    n_11: json["n_11"]??'',
    bun: json["bun"]??'',
    cr: json["cr"]??'',
    plt: json["plt"]??'',
    pt: json["pt"]??'',
    ptt: json["ptt"]??'',
    inr: json["inr"]??'',
    trop: json["trop"]??false,
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
    "IsLab": labIsComplete,
    "Is724": is724IsComplete,
    "dateOfAddToSystem": dateOfAddToSystem,
  };
}