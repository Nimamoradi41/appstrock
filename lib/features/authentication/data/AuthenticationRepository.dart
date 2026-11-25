import 'package:dio/dio.dart';

import '../../../core/AppConfig.dart';
import '../../../core/api_client.dart';
import '../../../core/api_response.dart';
import '../model/ModelLogin.dart';
import '../model/ModelChangeshift.dart';
import '../model/ModelOtpCode.dart';
import '../model/ModelRigester.dart';

class AuthenticationRepository {
  final Dio _dio;

  AuthenticationRepository({Dio? dio}) : _dio = dio ?? ApiClient.instance.dio;

  Future<ModelChangeshift> changeShiftStatus({required String userId}) async {
    final data = await _postForm('/Users/ChangeShiftStatus', {'id': userId});
    if (data['success'] == true &&
        (data['data'] is! Map || (data['data'] as Map)['isOnline'] is! bool)) {
      throw const FormatException('Invalid shift status response');
    }
    return ModelChangeshift.fromJson(data);
  }

  Future<ModelRigester> register({
    required String name,
    required String departmentId,
    required String nationalCode,
    required String mobileNumber,
    required String password,
  }) async {
    final data = await _postForm(AppConfig.registerPath, {
      'Name': name,
      'NationalCode': nationalCode,
      'MobileNumber': mobileNumber,
      'DepartmentId': departmentId,
      'Password': password,
    });
    return ModelRigester.fromJson(data);
  }

  Future<ModelLogin> login({
    required String name,
    required String nationalCode,
    required String password,
  }) async {
    final data = await _postForm(AppConfig.loginPath, {
      'Name': name,
      'NationalCode': nationalCode,
      'Password': password,
    });
    return ModelLogin.fromJson(data);
  }

  Future<ModelOtpCode> checkConfirmCode({
    required String id,
    required String code,
  }) async {
    final data = await _postForm(
      AppConfig.confirmCodePath,
      {'id': id, 'code': code},
      acceptedStatusCodes: const {200, 400, 403, 404},
    );
    return ModelOtpCode.fromJson(data);
  }

  Future<ModelOtpCode> sendAgain({
    required String id,
    required String mobileNumber,
  }) async {
    final data = await _postForm(
      AppConfig.resendCodePath,
      {'id': id, 'mobileNumber': mobileNumber},
      acceptedStatusCodes: const {200, 400, 403, 404},
    );
    return ModelOtpCode.fromJson(data);
  }

  Future<Map<String, dynamic>> changeUserInfo({
    required int id,
    String? name,
    String? nationalCode,
    int? departmentId,
    String? password,
  }) async {
    final response = await _dio.patch<dynamic>(
      '/Users/ChangeUserInfo',
      data: FormData.fromMap({
        'id': id,
        if (name != null && name.isNotEmpty) 'Name': name,
        if (nationalCode != null && nationalCode.isNotEmpty) 'NationalCode': nationalCode,
        if (departmentId != null) 'DepartmentId': departmentId,
        if (password != null && password.isNotEmpty) 'Password': password,
      }),
      options: Options(
        contentType: Headers.multipartFormDataContentType,
        validateStatus: (status) => status == 200 || status == 400,
      ),
    );
    return ApiResponse.object(response.data);
  }

  Future<Map<String, dynamic>> changeMobileNumber({
    required int id,
    required String mobileNumber,
  }) async {
    final response = await _dio.post<dynamic>(
      '/Users/ChangeMobileNumber',
      data: FormData.fromMap({'id': id, 'mobileNumber': mobileNumber}),
      options: Options(
        contentType: Headers.multipartFormDataContentType,
        validateStatus: (status) => status == 200 || status == 400,
      ),
    );
    return ApiResponse.object(response.data);
  }

  Future<ModelLogin> changeUserInfoLegacy({
    required String id,
    required String name,
    required String nationalCode,
    required String password,
  }) async {
    final data = await _postForm('/Users/ChangeUserInfo', {
      'id': id,
      'fullName': name,
      'nationalCode': nationalCode,
      'password': password,
    });
    return ModelLogin.fromJson(data);
  }

  Future<Map<String, dynamic>> _postForm(
    String path,
    Map<String, String> fields, {
    Set<int> acceptedStatusCodes = const {200, 400},
  }) async {
    final response = await _dio.post<dynamic>(
      path,
      data: FormData.fromMap(fields),
      options: Options(
        contentType: Headers.multipartFormDataContentType,
        // Validation failures are returned as models for the existing screens.
        validateStatus: (status) => acceptedStatusCodes.contains(status),
      ),
    );
    return ApiResponse.object(response.data);
  }
}
