import 'package:dio/dio.dart';

import '../../../core/api_client.dart';
import '../../../core/api_response.dart';
import '../model/ModelAddPatient.dart';
import '../model/patient_registration.dart';

class PatientRepository {
  PatientRepository({Dio? dio}) : _dio = dio ?? ApiClient.instance.dio;

  final Dio _dio;

  Future<ModelAddPatient> register(PatientRegistration patient) async {
    final response = await _dio.post<dynamic>(
      '/Patients',
      data: FormData.fromMap(patient.toFields()),
      options: Options(
        contentType: Headers.multipartFormDataContentType,
        validateStatus: (status) => status == 200 || status == 400,
      ),
    );
    return ModelAddPatient.fromJson(ApiResponse.object(response.data));
  }
}
