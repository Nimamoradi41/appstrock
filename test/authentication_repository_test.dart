import 'package:appstrock/features/authentication/data/AuthenticationRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('change shift sends user id and reads status from the server', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? sent;
    var isOnline = true;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      sent = request;
      handler.resolve(Response<dynamic>(
        requestOptions: request,
        statusCode: 200,
        data: {'success': true, 'message': '', 'data': {'id': 42, 'isOnline': isOnline}},
      ));
    }));
    final result = await AuthenticationRepository(dio: dio).changeShiftStatus(userId: '42');
    expect(sent!.path, '/Users/ChangeShiftStatus');
    expect(sent!.method, 'POST');
    expect(Map.fromEntries((sent!.data as FormData).fields), {'id': '42'});
    expect(result.data!.isOnline, isTrue);
    isOnline = false;
    final inactive = await AuthenticationRepository(dio: dio).changeShiftStatus(userId: '42');
    expect(inactive.data!.isOnline, isFalse);
  });

  test('authentication and account requests use the expected API contract', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    final requests = <RequestOptions>[];
    dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      requests.add(request);
      handler.resolve(Response<dynamic>(
        requestOptions: request,
        statusCode: 200,
        data: {'success': true, 'message': '', 'data': null},
      ));
    }));
    final repository = AuthenticationRepository(dio: dio);
    await repository.register(name: 'name', departmentId: '7', nationalCode: '123', mobileNumber: '0912', password: 'pass');
    await repository.login(name: 'name', nationalCode: '123', password: 'pass');
    await repository.checkConfirmCode(id: '42', code: '1234');
    await repository.sendAgain(id: '42', mobileNumber: '0912');
    await repository.changeUserInfo(id: 42, name: 'name', nationalCode: '123', departmentId: 7, password: 'pass');
    await repository.changeMobileNumber(id: 42, mobileNumber: '0912');
    await repository.changeUserInfoLegacy(id: '42', name: 'name', nationalCode: '123', password: 'pass');

    void check(int index, String method, String path, Map<String, String> fields) {
      final request = requests[index];
      expect(request.method, method);
      expect(request.path, path);
      expect(Map.fromEntries((request.data as FormData).fields), fields);
    }
    check(0, 'POST', '/Users/Register', {'Name': 'name', 'DepartmentId': '7', 'NationalCode': '123', 'MobileNumber': '0912', 'Password': 'pass'});
    check(1, 'POST', '/Users/Login', {'Name': 'name', 'NationalCode': '123', 'Password': 'pass'});
    check(2, 'POST', '/Users/CheckConfirmCode', {'id': '42', 'code': '1234'});
    check(3, 'POST', '/Users/TryAgain', {'id': '42', 'mobileNumber': '0912'});
    check(4, 'PATCH', '/Users/ChangeUserInfo', {'id': '42', 'Name': 'name', 'NationalCode': '123', 'DepartmentId': '7', 'Password': 'pass'});
    check(5, 'POST', '/Users/ChangeMobileNumber', {'id': '42', 'mobileNumber': '0912'});
    check(6, 'POST', '/Users/ChangeUserInfo', {'id': '42', 'fullName': 'name', 'nationalCode': '123', 'password': 'pass'});
  });
}
