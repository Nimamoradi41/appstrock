import 'dart:async';

import 'package:appstrock/features/patients/data/patient_repository.dart';
import 'package:appstrock/features/patients/viewmodel/attend_patients_view_model.dart';
import 'package:appstrock/features/patients/viewmodel/resident_patients_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

Map<String, dynamic> patient(int id, bool? status,
    {bool finished = false, bool is724Complete = false}) => {
  'id': id, 'fullName': 'بیمار $id', 'isNot724': status,
  'isFinished': finished, 'is724IsComplete': is724Complete,
  'insertTimeTS': 1700000000000,
};

void main() {
  test('stroke nurse lists active and finished patients for today and ranges', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final requests = <RequestOptions>[];
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {
        'success': true,
        'data': [patient(1, false), patient(2, false, is724Complete: true),
          patient(3, true), patient(4, true, finished: true)],
      }));
    }));
    final model = AttendPatientsViewModel(repository: PatientRepository(dio: dio), strokeNurse: true);
    await model.refresh();
    expect(model.patients.map((entry) => entry.patient.id), [1, 2, 4]);
    await model.setRange(Jalali(1405, 1, 1), Jalali(1405, 1, 3));
    expect(requests.map((request) => request.path), ['/Patients/PatientList', '/Patients/PatientListBetweenDate']);
    expect(model.patients.map((entry) => entry.patient.id), [1, 2, 4]);
    model.dispose();
  });
  test('attending request uses the date range and keeps eligible patients', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? request;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {
        'success': true,
        'data': [patient(1, null), patient(2, false, is724Complete: true),
          patient(3, true, finished: true), patient(4, true, is724Complete: true),
          patient(5, null, is724Complete: true)],
      }));
    }));
    final items = await PatientRepository(dio: dio).listForAttend('1405/01/01', '1405/01/03');
    expect(request!.path, '/Patients/PatientForAttend');
    expect(Map.fromEntries((request!.data as FormData).fields),
        {'startDate': '1405/01/01', 'endDate': '1405/01/03'});
    expect(items.map((entry) => entry.patient.id), [2, 3, 4, 5]);
    expect(items.map((entry) => entry.status),
        [PatientStatus.active724, PatientStatus.finished,
          PatientStatus.active724, PatientStatus.active724]);
  });

  test('statuses follow the isFinished/isNot724/is724IsComplete rules', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {
        'success': true,
        'data': [
          patient(1, null),
          patient(2, false),
          patient(3, true),
          patient(4, false, is724Complete: true),
          patient(5, true, is724Complete: true),
          patient(6, null, finished: true),
          patient(7, true, finished: true),
        ],
      }));
    }));
    final items = await PatientRepository(dio: dio).listForDate('1405/01/01');
    expect(items.map((entry) => entry.status), [
      PatientStatus.waiting,
      PatientStatus.waiting,
      PatientStatus.not724,
      PatientStatus.active724,
      PatientStatus.active724,
      PatientStatus.finished,
      PatientStatus.finished,
    ]);
    expect(items.where((entry) => entry.needsAction).map((entry) => entry.patient.id),
        [1, 2]);
    expect(items.where((entry) => entry.isCode724).map((entry) => entry.patient.id),
        [4, 5]);
    expect(items.where((entry) => entry.isCompleted).map((entry) => entry.patient.id),
        [6, 7]);
  });

  test('attending view model requests the same endpoint for today and ranges', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final requests = <RequestOptions>[];
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests.add(options);
      handler.resolve(Response(requestOptions: options, statusCode: 200,
          data: {'success': true, 'data': []}));
    }));
    final model = AttendPatientsViewModel(repository: PatientRepository(dio: dio));
    await model.refresh();
    await model.setRange(Jalali(1405, 1, 1), Jalali(1405, 1, 3));
    expect(requests.map((request) => request.path),
        ['/Patients/PatientForAttend', '/Patients/PatientForAttend']);
    expect(Map.fromEntries((requests.last.data as FormData).fields),
        {'startDate': '1405/01/01', 'endDate': '1405/01/03'});
    model.dispose();
  });

  test('preserves null and gives finished priority over 724 status', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? request;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {
        'success': true, 'data': [patient(1, null), patient(2, false),
          patient(3, false, finished: true), patient(4, true),
          patient(5, false, is724Complete: true)]
      }));
    }));
    final items = await PatientRepository(dio: dio).listBetweenDates('1405/01/01', '1405/01/03');
    expect(request!.path, '/Patients/PatientListBetweenDate');
    expect(Map.fromEntries((request!.data as FormData).fields), {'startDate': '1405/01/01', 'endDate': '1405/01/03'});
    expect(items.map((e) => e.status), [PatientStatus.waiting, PatientStatus.waiting,
      PatientStatus.finished, PatientStatus.not724, PatientStatus.active724]);
    expect(items.first.isNot724, isNull);
  });

  test('changing date while a request is in flight ignores its stale response', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final first = Completer<void>();
    final requested = <RequestOptions>[];
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      requested.add(options);
      if (requested.length == 1) await first.future;
      handler.resolve(Response(requestOptions: options, statusCode: 200,
          data: {'success': true, 'data': [patient(requested.length == 1 ? 1 : 2, null)]}));
    }));
    final model = ResidentPatientsViewModel(repository: PatientRepository(dio: dio));
    final initial = model.refresh();
    await Future<void>.delayed(Duration.zero);
    await model.setRange(Jalali(1405, 1, 1), Jalali(1405, 1, 3));
    first.complete();
    await initial;
    for (var i = 0; i < 20 && (model.loading || requested.length < 2); i++) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    expect(requested.map((r) => r.path), ['/Patients/PatientList', '/Patients/PatientListBetweenDate']);
    expect(model.patients.single.patient.id, 2);
    model.dispose();
  });
}
