
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import 'Models/ModelLogin.dart';
import 'Models/ModelOtpCode.dart';


class ApiServiceAutentication{
  static Future<ModelRigester?> Rigester(String Name,String Typeuser,
      String NationalCode,String PhoneNumber,String Password,BuildContext context) async {
    ModelRigester? login ;


    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Users/Register'));



    // request.headers.addAll({
    //   'Content-Type': 'multipart/form-data',
    //   'Accept': '*/*',
    // });
    request.headers['Content-Type'] = 'application/json", "Accept": "application/json';
    request.fields.addAll({
      'Name': Name,
      'NationalCode': NationalCode,
      'MobileNumber': PhoneNumber,
      'DepartmentId': Typeuser,
      'Password': Password
    });

    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        Navigator.pop(context);
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;



      print(response.statusCode.toString());

      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        if(str != null && str.isNotEmpty) {
          ModelRigester data = modelRigesterFromJson(str);
          login = data;
        } else {
          // Handle the case where response is empty or null
          ShowErrorMsg(context, 'مشکلی در دریافت اطلاعات از سرور به وجود آمده');
        }
      }

      if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        print(str);
        if(str != null && str.isNotEmpty) {
          ModelRigester data = modelRigesterFromJson(str);
          login = data;
        } else {
          // Handle the case where response is empty or null
          ShowErrorMsg(context, 'مشکلی در دریافت اطلاعات از سرور به وجود آمده');
        }
      }

    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }

    Navigator.pop(context);
    return login;
  }
  static Future<ModelLogin?> Login(String Name,
      String NationalCode,String Pass,BuildContext context) async {
    ModelLogin? login;
    var request = http.MultipartRequest('POST', Uri.parse('https://api.appstrok.ir/Users/Login'));
    request.headers.addAll({"content-type":"application/json; charset=utf-8"});

    request.fields.addAll({
      'Name': Name,
      'NationalCode': NationalCode,
      'Password': Pass,
    });




    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        Navigator.pop(context);
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;

      print(response.statusCode.toString());
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        ModelLogin data= await  modelLoginFromJson(str);
        login=data;
      }

      if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelLogin data= await  modelLoginFromJson(str);
        login=data;
      }

    }  on SocketException catch (e) {
      Navigator.pop(context);
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      Navigator.pop(context);
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    }













    Navigator.pop(context);
    return login;
  }
  static Future<ModelOtpCode?>


  CheckConfirmCode(String Id,String Code,BuildContext context) async {
    ModelOtpCode? login;
    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Users/CheckConfirmCode'));
    request.headers['Content-Type'] = 'application/json", "Accept": "application/json';
    request.fields.addAll({
      'id': Id,
      // 'id': '31',
      'code': Code,
    });

    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        Navigator.pop(context);
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;

      print(response.statusCode.toString());
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }
      if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }

      if(response.statusCode==404)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }

      if(response.statusCode==403)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    }







    Navigator.pop(context);
    return login;
  }

 static SendAgain(String Id,String mobileNumber,BuildContext context) async {
    ModelOtpCode? login;
    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Users/TryAgain'));
    request.headers['Content-Type'] = 'application/json", "Accept": "application/json';
    request.fields.addAll({
      'id': Id,
      'mobileNumber': mobileNumber,
    });

    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        Navigator.pop(context);
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;

      print(response.statusCode.toString());
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }
      if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }

      if(response.statusCode==404)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }

      if(response.statusCode==403)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    }







    Navigator.pop(context);
    return login;
  }



}