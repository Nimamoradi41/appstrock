import 'package:shared_preferences/shared_preferences.dart';

import '../model/ModelLogin.dart';


class LoginSessionStorage {
  Future<void> save({
    required String name,
    required String nationalCode,
    required String password,
    required Data user,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('Name', name);
    await preferences.setString('Code', nationalCode);
    await preferences.setBool('Login', true);
    await preferences.setBool('isOnline', user.isOnline);
    await preferences.setInt('TypeUser', user.departmentId);
    await preferences.setString('Pass', password);
    await preferences.setString('UserId', user.id.toString());
  }
}
