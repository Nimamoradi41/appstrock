enum PatientRegistrationSource {
  triage('1'),
  ems('2'),
  attending('3'),
  resident('4');

  const PatientRegistrationSource(this.apiValue);
  final String apiValue;
}

class PatientRegistration {
  const PatientRegistration({
    required this.fullName,
    required this.nationalCode,
    required this.age,
    required this.genderId,
    required this.source,
    required this.registeredDate,
    required this.registeredAt,
    required this.registeredBy,
    this.withoutInfo = false,
  });

  final String fullName;
  final String nationalCode;
  final String age;
  final int genderId;
  final PatientRegistrationSource source;
  final String registeredDate;
  final DateTime registeredAt;
  final String registeredBy;
  final bool withoutInfo;

  Map<String, String> toFields() => {
        if (!withoutInfo) 'FullName': fullName,
        'Date': registeredDate,
        if (!withoutInfo) 'NationalCode': nationalCode,
        if (!withoutInfo) 'Age': age,
        'typeInput': source.apiValue,
        if (!withoutInfo) 'GenderId': genderId.toString(),
        if (withoutInfo) 'WithoutInfo': 'true',
        'InsertBy': registeredBy,
        'insertTimeTs': registeredAt.millisecondsSinceEpoch.toString(),
      };
}
