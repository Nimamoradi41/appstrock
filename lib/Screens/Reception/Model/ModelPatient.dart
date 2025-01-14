
class ModelPatient {
  int id;
  String fullName;
  String nationalCode;
  String dtn;
  String otn;
  String age;
  String gender;
  String timeOfAddToSystem;
  String? timeOfAddLabotory;
  String? timeOfInjection;
  int? bloodPressure1;
  int? bloodPressure2;
  int? signsStartTS;
  int? injectionTimeTS;
  int? insertTimeTS;
  int? injectionType;
  String? signsStartTime;
  String? timeFinish;
  int? nihsSubscore;
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
  bool? notInjectingIsComplete;
  bool? isFinished;
  bool?  labIsComplete;
  bool?  is724IsComplete;
  bool?  isNot724IsComplete;
  bool?  misdiagnosisOfTriage;
  bool?  misdiagnosisOfEms;
  bool?  overTime;
  bool?  seenByAttend;
  bool?  signsStartIsUnknown;
  String?  n_1_a;
  String?  labInsertDate;
  String?  dateFinishShamsi;
  String?  n_1_b;
  String?  n_1_c;
  String?  labInsertTime;
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
  String?  wbc;
  String?  hb;
  bool?  c1;
  bool?  c2;
  bool?  c3;
  bool?  c4;
  bool?  c5;
  bool?  c6;
  bool?  c7;
  bool?  c8;
  bool?  c9;
  bool?  c10;
  bool?  c11;
  bool?  c12;
  bool?  c13;
  bool?  c14;
  bool?  c15;
  bool?  c16;
  bool?  c17;
  bool?  c18;
  bool?  c19;
  bool?  c20;
  bool?  c21;
  bool?  c22;
  bool?  trop;
  int?  bs;


  ModelPatient({
    required this.id,
    required this.fullName,
    required this.nationalCode,
    required this.otn,
    required this.dtn,
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
    required this.isFinished,
    required this.notInjectingIsComplete,
    required this.wbc,

    required this.ResonNot,
    required this.nihsSubscore,
    required this.needToMRI,
    required this.Residents,
    required this.isNot724,
    required this.needToCT,
    required this.nihsIsComplete,
    required this.labIsComplete,
    required this.is724IsComplete,
    required this.isNot724IsComplete,
    required this.misdiagnosisOfTriage,
    required this.injectionTimeTS,
    required this.misdiagnosisOfEms,
    required this.overTime,
    required this.seenByAttend,
    required this.signsStartIsUnknown,
    required this.timeOfInjection,
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
    required this.bloodPressure1,
    required this.bloodPressure2,
    required this.bs,
    required this.signsStartTS,
    required this.insertTimeTS,
    required this.injectionType,
    required this.labInsertDate,
    required this.labInsertTime,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    required this.c7,
    required this.c8,
    required this.c9,
    required this.c10,
    required this.c11,
    required this.c12,
    required this.c13,
    required this.c14,
    required this.c15,
    required this.c16,
    required this.c17,
    required this.c18,
    required this.c19,
    required this.c20,
    required this.c21,
    required this.c22,
    required this.hb,
    required this.timeFinish,
    required this.dateFinishShamsi,
  });

  factory ModelPatient.fromJson(Map<String, dynamic> json) => ModelPatient(
    id: json["id"]?? '',
    dtn: json["dtn"]?? '',
    otn: json["otn"]?? '',
    timeFinish: json["timeFinish"]?? '',
    dateFinishShamsi: json["dateFinishShamsi"]?? '',
    fullName: json["fullName"]?? '',
    nationalCode: json["nationalCode"]?? '',
    age: json["age"]?? '',
    gender: json["gender"]?? '',
    timeOfAddToSystem: json["timeOfAddToSystem"]?? '',
    fssTime: json["fssTime"]?? '',
    labInsertDate: json["labInsertDate"]?? '',
    signsStartDate: json["signsStartDate"]?? '',
    labInsertTime: json["labInsertTime"]?? '',
    Residents: json["Residents"]?? '',
    lkwTime: json["lkwTime"]?? '',
    wbc: json["wbc"]?? '',
    hb: json["hb"]?? '',
    fssDate: json["fssDate"]?? '',
    nihsSubscore: json["nihsSubscore"]?? 0,
    lkwDate: json["lkwDate"]?? '',
    bloodPressure1: json["bloodPressure1"]?? 0,
    bloodPressure2: json["bloodPressure2"]?? 0,
    bs: json["bs"]?? 0,
    insertTimeTS: json["insertTimeTS"]?? 0,
    signsStartTS: json["signsStartTS"]?? 0,
    injectionType: json["injectionType"]?? 0,
    Atends: json["Atends"]?? '',
    Fesharkhon: json["Fesharkhon"]?? '',
    Ghandkhon: json["Ghandkhon"]?? '',
    dateOfAddToSystem: json["dateOfAddToSystem"]?? '',
    dateOfAddToStart: json["dateOfAddToStart"]?? '',
    signsStartTime: json["signsStartTime"]?? '',
    injectionTimeTS: json["injectionTimeTS"]?? 0,
    timeOfAddLabotory: json["timeOfAddLabotory"]?? '',
    timeOfInjection: json["timeOfInjection"]?? '',
    ResonNot: json["ResonNot"]??'',
    needToMRI: json["needToMRI"]??false,
    c1: json["c1"]??false,
    c2: json["c2"]??false,
    c3: json["c3"]??false,
    c4: json["c4"]??false,
    c5: json["c5"]??false,
    c6: json["c6"]??false,
    c7: json["c7"]??false,
    c8: json["c8"]??false,
    c9: json["c9"]??false,
    c10: json["c10"]??false,
    c11: json["c11"]??false,
    c12: json["c12"]??false,
    c13: json["c13"]??false,
    c14: json["c14"]??false,
    c15: json["c15"]??false,
    c16: json["c16"]??false,
    c17: json["c17"]??false,
    c18: json["c18"]??false,
    c19: json["c19"]??false,
    c20: json["c20"]??false,
    c21: json["c21"]??false,
    c22: json["c22"]??false,
    isFinished: json["isFinished"]??false,
    misdiagnosisOfTriage: json["misdiagnosisOfTriage"]??false,
    misdiagnosisOfEms: json["misdiagnosisOfEms"]??false,
    notInjectingIsComplete: json["notInjectingIsComplete"]??false,
    isNot724: json["isNot724"]??false,
    needToCT: json["needToCT"]??false,
    nihsIsComplete: json["nihsIsComplete"]??false,
    labIsComplete: json["labIsComplete"]??false,
    is724IsComplete: json["is724IsComplete"]??false,
    isNot724IsComplete: json["isNot724IsComplete"]??false,
    overTime: json["overTime"]??false,
    seenByAttend: json["seenByAttend"]??false,
    signsStartIsUnknown: json["signsStartIsUnknown"]??false,
    n_1_a: json["n_1_a"]??'0',
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