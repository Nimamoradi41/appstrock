import 'package:dio/dio.dart';

import '../../../core/api_client.dart';
import '../../../core/api_response.dart';
import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';

enum PatientStatus { waiting, active724, finished, not724 }

class PatientListEntry {
  PatientListEntry({required this.patient, required this.isNot724, this.source});

  factory PatientListEntry.fromJson(Map<String, dynamic> json) {
    final rawStatus = json['isNot724'];
    if (rawStatus != null && rawStatus is! bool) {
      throw const FormatException('وضعیت بیمار نامعتبر است');
    }
    return PatientListEntry(
      patient: ModelPatient.fromJson(json),
      isNot724: rawStatus as bool?,
      source: json['typeInput']?.toString(),
    );
  }

  final ModelPatient patient;
  final bool? isNot724;
  final String? source;

  PatientStatus get status {
    if (patient.isFinished == true) return PatientStatus.finished;
    if (patient.is724IsComplete == true) return PatientStatus.active724;
    if (isNot724 == true) return PatientStatus.not724;
    return PatientStatus.waiting;
  }

  /// نیازمند اقدام: هنوز نه ۷۲۴ ثبت شده و نه پرونده بسته شده است.
  bool get needsAction => status == PatientStatus.waiting;

  /// کد ۷۲۴: کد ۷۲۴ تایید شده و پرونده هنوز تکمیل نشده است.
  bool get isCode724 => status == PatientStatus.active724;

  /// تکمیل شده: پرونده بیمار بسته شده است.
  bool get isCompleted => status == PatientStatus.finished;
}

class PatientRepository {
  PatientRepository({Dio? dio}) : _dio = dio ?? ApiClient.instance.dio;
  final Dio _dio;

  Future<List<PatientListEntry>> listForDate(String date) =>
      _list('/Patients/PatientList', {'date': date});

  Future<List<PatientListEntry>> listBetweenDates(String start, String end) =>
      _list('/Patients/PatientListBetweenDate', {'startDate': start, 'endDate': end});

  Future<List<PatientListEntry>> listForAttend(String start, String end) async {
    final patients = await _list('/Patients/PatientForAttend',
        {'startDate': start, 'endDate': end});
    return List.unmodifiable(
        patients.where((entry) => entry.isCode724 || entry.isCompleted));
  }

  Future<List<PatientListEntry>> _list(String path, Map<String, String> fields) async {
    final response = await _dio.post<dynamic>(path,
        data: FormData.fromMap(fields),
        options: Options(contentType: Headers.multipartFormDataContentType,
            validateStatus: (status) => status == 200 || status == 400));
    final result = ApiResponse.object(response.data);
    if (result['success'] != true) {
      throw PatientListException(result['message']?.toString() ?? 'دریافت بیماران ناموفق بود');
    }
    final data = result['data'];
    if (data is! List) throw const FormatException('فهرست بیماران نامعتبر است');
    return List.unmodifiable(data.map((item) {
      if (item is! Map) throw const FormatException('اطلاعات بیمار نامعتبر است');
      return PatientListEntry.fromJson(Map<String, dynamic>.from(item));
    }));
  }
}

class PatientListException implements Exception {
  const PatientListException(this.message);
  final String message;
  @override
  String toString() => message;
}
