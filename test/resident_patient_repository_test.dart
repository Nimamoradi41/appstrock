import 'package:appstrock/features/patients/data/patient_repository.dart';
import 'package:appstrock/features/patients/data/resident_patient_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

void main() {
  test('sends blood sugar and blood pressure to the patient signs endpoint', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final requests = <RequestOptions>[];
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': true}));
    }));
    final repository = ResidentPatientRepository(dio: dio, userId: () async => '9');
    expect((await repository.saveBloodSugar('42', '124')).success, isTrue);
    expect((await repository.saveBloodPressure('42', '120', '80')).success, isTrue);
    expect(requests.map((request) => request.path), ['/Patients/AddPatientSigns', '/Patients/AddPatientSigns']);
    expect(Map.fromEntries((requests[0].data as FormData).fields), {'patientId': '42', 'userId': '9', 'bs': '124'});
    expect(Map.fromEntries((requests[1].data as FormData).fields), {'patientId': '42', 'userId': '9', 'bloodPressure1': '120', 'bloodPressure2': '80'});
  });
  test('sends NIHSS answers and score to add and update endpoints', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final requests = <RequestOptions>[];
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': true}));
    }));
    final repository = ResidentPatientRepository(dio: dio, userId: () async => '9');
    final answers = List.generate(15, (index) => <String, dynamic>{'selected_answer': index % 3});
    await repository.saveNihss('42', answers, 15, update: false);
    await repository.saveNihss('42', answers, 15, update: true);
    expect(requests.map((request) => request.path), ['/Patients/AddNihsForm', '/Patients/UpdateNihsForm']);
    for (final request in requests) {
      final fields = Map.fromEntries((request.data as FormData).fields);
      expect(fields['patientId'], '42');
      expect(fields['userId'], '9');
      expect(fields['subscore'], '15');
      expect(fields['N_1_a'], '0');
      expect(fields['N_5_a'], '0');
      expect(fields['N_5_b'], '1');
      expect(fields['N_11'], '2');
      expect(fields.length, 18);
    }
  });
  test('sends unanswered NIHSS fields as empty values', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? request;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': true}));
    }));
    final repository = ResidentPatientRepository(dio: dio, userId: () async => '9');
    final answers = List.generate(15, (index) => <String, dynamic>{'selected_answer': index == 1 ? 0 : null});
    await repository.saveNihss('42', answers, 0, update: true);
    final fields = Map.fromEntries((request!.data as FormData).fields);
    expect(fields['N_1_a'], '');
    expect(fields['N_1_b'], '0');
    expect(fields['N_11'], '');
  });
  test('sends known and unknown onset fields to the 724 endpoint', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final requests = <RequestOptions>[];
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': true}));
    }));
    final repository = ResidentPatientRepository(dio: dio, userId: () async => '9');
    Future<void> submit(bool unknown) async {
      final result = await repository.set724('42', unknown: unknown,
          startTime: unknown ? '' : '12:30', startDate: unknown ? '' : '1405/08/26',
          fssTime: unknown ? '12:00' : '', fssDate: unknown ? '1405/08/26' : '',
          lkwTime: unknown ? '11:00' : '', lkwDate: unknown ? '1405/08/26' : '',
          timestamp: '100', lkwTimestamp: '200', fssTimestamp: '300');
      expect(result.success, isTrue);
    }
    await submit(false);
    await submit(true);
    final known = Map.fromEntries((requests[0].data as FormData).fields);
    final unknown = Map.fromEntries((requests[1].data as FormData).fields);
    expect(requests.every((request) => request.path == '/Patients/Set724Status'), isTrue);
    expect(known, containsPair('signsStartTS', '100'));
    expect(known, containsPair('signsStartDate', '1405/08/26'));
    expect(known.containsKey('signsStartTSLKW'), isFalse);
    expect(unknown, containsPair('signsStartTSLKW', '200'));
    expect(unknown, containsPair('signsStartTSFSS', '300'));
    expect(unknown, containsPair('lkwTime', '11:00'));
    expect(unknown, containsPair('fssTime', '12:00'));
    expect(unknown.containsKey('signsStartTS'), isFalse);
  });
  test('sends the three non-724 reasons for the selected patient', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? request;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(
          requestOptions: options, statusCode: 200, data: {'success': true}));
    }));
    final repository =
        ResidentPatientRepository(dio: dio, userId: () async => '9');
    final result = await repository.saveNot724Reasons('42', true, false, true);
    expect(result.success, isTrue);
    expect(request!.path, '/Patients/ReasonsForIsNot724');
    expect(Map.fromEntries((request!.data as FormData).fields), {
      'patientId': '42',
      'userId': '9',
      'MisdiagnosisOfTriage': 'true',
      'MisdiagnosisOfEms': 'false',
      'OverTime': 'true',
    });
  });
  test('uploads the selected patient image as multipart data', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? request;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200));
    }));
    final repository =
        ResidentPatientRepository(dio: dio, userId: () async => '9');
    final result = await repository.uploadImage('42',
        Uint8List.fromList([1, 2]), 'scan.png', MediaType('image', 'png'));
    expect(result.success, isTrue);
    final form = request!.data as FormData;
    expect(request!.path, '/Patients/AddImages');
    expect(Map.fromEntries(form.fields), {'patientId': '42', 'userId': '9'});
    expect(form.files.single.key, 'Images');
    expect(form.files.single.value.filename, 'scan.png');
  });

  test('does not report upload success when the server rejects it in a 200 response', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': false, 'message': 'خطای ثبت'}));
    }));
    final repository = ResidentPatientRepository(dio: dio, userId: () async => '9');
    final result = await repository.uploadImage('42', Uint8List.fromList([1]), 'scan.png', MediaType('image', 'png'));
    expect(result.success, isFalse);
    expect(result.message, 'خطای ثبت');
  });

  test(
      'fetches the requested patient independently and reports missing patients',
      () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? request;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {
        'success': true,
        'data': [
          {'id': 1, 'fullName': 'اول'},
          {'id': 2, 'fullName': 'دوم'},
        ],
      }));
    }));
    final repository = ResidentPatientRepository(dio: dio);
    final patient = await repository.getPatient(
        patientId: 2, from: '1405/01/01', to: '1405/01/02');
    expect(patient.fullName, 'دوم');
    expect(request!.path, '/Patients/PatientListBetweenDate');
    expect(Map.fromEntries((request!.data as FormData).fields),
        {'startDate': '1405/01/01', 'endDate': '1405/01/02'});
    expect(
        () => repository.getPatient(
            patientId: 3, from: '1405/01/01', to: '1405/01/02'),
        throwsA(isA<PatientListException>()));
  });

  test('sends 724 decision with patient and user identifiers', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? request;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(
          requestOptions: options, statusCode: 200, data: {'success': true}));
    }));
    final repository =
        ResidentPatientRepository(dio: dio, userId: () async => '9');
    final result = await repository.setNot724('42', '123');
    expect(result.success, isTrue);
    expect(request!.path, '/Patients/Set724Status');
    expect(Map.fromEntries((request!.data as FormData).fields), {
      'id': '42',
      'userId': '9',
      'status': 'false',
      'signsStartTS': '123',
    });
  });

  test('does not submit patient changes without a user id', () async {
    var called = false;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      called = true;
      handler.resolve(Response(requestOptions: options, statusCode: 200));
    }));
    final result =
        await ResidentPatientRepository(dio: dio, userId: () async => null)
            .setNot724('42', '123');
    expect(result.success, isFalse);
    expect(called, isFalse);
  });
}
