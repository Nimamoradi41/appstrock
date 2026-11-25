import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../core/api_client.dart';
import '../../../core/api_exception.dart';
import '../../../core/api_response.dart';
import 'patient_repository.dart';

class ResidentPatientRepository {
  ResidentPatientRepository({Dio? dio, Future<String?> Function()? userId})
      : _dio = dio ?? ApiClient.instance.dio,
        _userId = userId ?? _readUserId;

  final Dio _dio;
  final Future<String?> Function() _userId;

  static Future<String?> _readUserId() async =>
      (await SharedPreferences.getInstance()).getString('UserId');

  Future<ModelPatient> getPatient(
      {required int patientId,
      required String from,
      required String to}) async {
    final entries =
        await PatientRepository(dio: _dio).listBetweenDates(from, to);
    for (final entry in entries) {
      if (entry.patient.id == patientId) return entry.patient;
    }
    throw const PatientListException(
        'پرونده بیمار در بازه انتخاب‌شده پیدا نشد');
  }

  Future<PatientOperationResult> _post(
      String endpoint, Map<String, dynamic> fields,
      {String userIdKey = 'userId', bool successOnHttp200 = false}) async {
    try {
      final userId = await _userId();
      if (userId == null || userId.isEmpty) {
        return const PatientOperationResult(
            false, 'اطلاعات کاربر در دسترس نیست');
      }
      final response = await _dio.post<dynamic>(endpoint,
          data: FormData.fromMap({...fields, userIdKey: userId}),
          options: Options(
              contentType: Headers.multipartFormDataContentType,
              validateStatus: (status) =>
                  status == 200 || status == 400 || status == 403));
      if (successOnHttp200 && response.statusCode == 200) {
        return const PatientOperationResult(true, '');
      }
      final result = ApiResponse.object(response.data);
      return PatientOperationResult(result['success'] == true,
          result['message']?.toString() ?? 'عملیات ناموفق بود');
    } on ApiException catch (error) {
      return PatientOperationResult(false, error.toString());
    } on DioException catch (_) {
      return const PatientOperationResult(
          false, 'مشکلی در ارتباط با سرور به وجود آمده');
    } catch (_) {
      return const PatientOperationResult(false, 'دریافت پاسخ سرور ناموفق بود');
    }
  }

  Future<PatientOperationResult> needToCT(String id) =>
      _post('/Patients/NeedToCT', {'id': id});
  Future<PatientOperationResult> needToMRI(String id) =>
      _post('/Patients/NeedToMRI', {'id': id});

  Future<PatientOperationResult> uploadImage(
          String id, Uint8List bytes, String fileName, MediaType contentType) =>
      _post(
          '/Patients/AddImages',
          {
            'patientId': id,
            'Images': MultipartFile.fromBytes(bytes,
                filename: fileName, contentType: contentType),
          },
          successOnHttp200: true);

  Future<PatientOperationResult> saveNihss(
      String id, List<Map<String, dynamic>> answers, int score,
      {required bool update}) {
    const keys = [
      'N_1_a',
      'N_1_b',
      'N_1_c',
      'N_2',
      'N_3',
      'N_4',
      'N_5_a',
      'N_5_b',
      'N_6_a',
      'N_6_b',
      'N_7',
      'N_8',
      'N_9',
      'N_10',
      'N_11'
    ];
    if (answers.length != keys.length) {
      return Future.value(
          const PatientOperationResult(false, 'اطلاعات ارزیابی کامل نیست'));
    }
    return _post(
        update ? '/Patients/UpdateNihsForm' : '/Patients/AddNihsForm', {
      'patientId': id,
      'subscore': '$score',
      for (var index = 0; index < keys.length; index++)
        keys[index]: answers[index]['selected_answer'].toString(),
    });
  }

  Future<PatientOperationResult> saveLab(
      String id, List<Map<String, dynamic>> answers,
      {required bool update}) {
    const keys = ['BUN', 'Cr', 'PLT', 'PT', 'INR', 'hb', 'wbc'];
    if (answers.length != 8) {
      return Future.value(
          const PatientOperationResult(false, 'اطلاعات آزمایش کامل نیست'));
    }
    return _post(
        update ? '/Patients/UpdateLabResult' : '/Patients/AddLabResult', {
      'patientId': id,
      for (var index = 0; index < keys.length; index++)
        keys[index]: answers[index]['selected_answer'].toString(),
      'Trop': (answers[7]['selected_answer'].toString() != '0').toString(),
    });
  }

  Future<PatientOperationResult> setNot724(String id, String timestamp) =>
      _post('/Patients/Set724Status',
          {'id': id, 'status': 'false', 'signsStartTS': timestamp});

  Future<PatientOperationResult> set724(String id,
          {required bool unknown,
          required String startTime,
          required String startDate,
          required String fssTime,
          required String fssDate,
          required String lkwTime,
          required String lkwDate,
          required String timestamp,
          required String lkwTimestamp,
          required String fssTimestamp}) =>
      _post('/Patients/Set724Status', {
        'id': id,
        'status': 'true',
        'isUnKnown': '$unknown',
        'signsStartDate': startDate,
        'signsStartTime': startTime,
        'fssTime': fssTime,
        'fssDate': fssDate,
        'lkwTime': lkwTime,
        'lkwDate': lkwDate,
        if (!unknown) 'signsStartTS': timestamp,
        if (unknown) 'signsStartTSLKW': lkwTimestamp,
        if (unknown) 'signsStartTSFSS': fssTimestamp,
      });

  Future<PatientOperationResult> saveNot724Reasons(
          String id, bool triage, bool ems, bool overTime) =>
      _post('/Patients/ReasonsForIsNot724', {
        'patientId': id,
        'MisdiagnosisOfTriage': '$triage',
        'MisdiagnosisOfEms': '$ems',
        'OverTime': '$overTime'
      });

  Future<PatientOperationResult> saveInjectionReason(
      String id, List<Map<String, dynamic>> answers) {
    if (answers.length != 22) {
      return Future.value(
          const PatientOperationResult(false, 'اطلاعات علت تزریق کامل نیست'));
    }
    return _post(
        '/Patients/SetInjectionStatus',
        {
          'id': id,
          'Description': 'test',
          'Status': 'false',
          'IsReason': 'true',
          for (var index = 0; index < 22; index++)
            'C${index + 1}': answers[index]['selected_answer'].toString(),
        },
        userIdKey: 'UserId');
  }

  Future<PatientOperationResult> saveBloodPressure(
          String id, String first, String second) =>
      _post('/Patients/AddPatientSigns',
          {'patientId': id, 'bloodPressure1': first, 'bloodPressure2': second});
  Future<PatientOperationResult> saveBloodSugar(String id, String value) =>
      _post('/Patients/AddPatientSigns', {'patientId': id, 'bs': value});
  Future<PatientOperationResult> saveInjection(
          String id, String time, String timestamp, String medicine) =>
      _post(
          '/Patients/TimeOfInjection',
          {
            'PatientId': id,
            'Time': time,
            'Medicine': medicine,
            'InjectionTimeTS': timestamp
          },
          userIdKey: 'UserId');
}

class PatientOperationResult {
  const PatientOperationResult(this.success, this.message);
  final bool success;
  final String message;
}
