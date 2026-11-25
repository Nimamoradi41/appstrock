enum PatientRegistrationSource {
  triage('1'),
  ems('2'),
  attending('3');

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
  });

  final String fullName;
  final String nationalCode;
  final String age;
  final int genderId;
  final PatientRegistrationSource source;
  final String registeredDate;
  final DateTime registeredAt;
  final String registeredBy;

  Map<String, String> toFields() => {
        'FullName': fullName,
        'Date': registeredDate,
        'NationalCode': nationalCode,
        'Age': age,
        'typeInput': source.apiValue,
        'GenderId': genderId.toString(),
        'InsertBy': registeredBy,
        'insertTimeTs': registeredAt.millisecondsSinceEpoch.toString(),
      };
}
