
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppConfig {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.appstroke.ir',
  );

  static const connectTimeout = Duration(seconds: 15);
  static const sendTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 15);


  /////// Resident
  static const inkColorResident = Color(0xff101d30);
  static const tealColorResident = Color(0xff007d83);
  static const borderColorResident = Color(0xffd4dee7);
  /////// Resident



  static const registerPath = '/Users/Register';
  static const loginPath = '/Users/Login';
  static const confirmCodePath = '/Users/CheckConfirmCode';
  static const resendCodePath = '/Users/TryAgain';


 static  String digits(String value) {
    const digits = '۰۱۲۳۴۵۶۷۸۹';
    return value.replaceAllMapped(
        RegExp('[0-9]'), (match) => digits[int.parse(match[0]!)]);
  }



 static BoxDecoration box() => BoxDecoration(
      color: const Color(0xfffbfcfe),
      border: Border.all(color: borderColorResident),
      borderRadius: BorderRadius.circular(10));

}
