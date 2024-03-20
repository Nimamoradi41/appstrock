
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
  static Future<ModelRigester> Rigester(String Name,String Typeuser,String NationalCode,String PhoneNumber,String Password,BuildContext context) async {
    var login;


    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Users/Register'));
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
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;

      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        ModelRigester data= modelRigesterFromJson(str);
       login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());


      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    }












    Navigator.pop(context);
    return login;
  }

  static Future<ModelLogin> Login(String Name,
      String NationalCode,BuildContext context) async {
    var login;


    // var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Users/Login'));
    // request.fields.addAll({
    //   'Name': Name,
    //   'NationalCode': NationalCode,
    // });
    //
    // try{
    //   http.StreamedResponse response = await request.send().timeout(
    //     Duration(seconds: 15),
    //   ).catchError((error) {
    //     ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    //
    //   }) ;
    //
    //   if(response.statusCode==200)
    //   {
    //     String str= await response.stream.bytesToString();
    //     ModelLogin data= await  modelLoginFromJson(str);
    //     login=data;
    //   }else{
    //     ShowErrorMsg(context,response.reasonPhrase.toString());
    //
    //
    //   }
    // }  on SocketException catch (e) {
    //   ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    //
    // } on TimeoutException catch (e) {
    //   ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    //
    //
    // }
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    // Navigator.pop(context);

    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Users/Login'));
    request.fields.addAll({
      'Name': 'فرامرز میرزاوند',
      'NationalCode': '1920180001',
      'Password': '123'
    });


    var data = FormData.fromMap({
      'Name': 'فرامرز میرزاوند',
      'NationalCode': '1920180001',
      'Password': '123'
    });

    var dio = Dio();
    var response = await dio.request(
      'https://fmirzavand.ir/Users/Login',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }

    Navigator.pop(context);
    return login;
  }





  static Future<ModelOtpCode>
  CheckConfirmCode(String Id,String Code,BuildContext context) async {
    var login;


    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Users/CheckConfirmCode'));
    request.fields.addAll({
      'id': Id,
      'code': Code,
    });

    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;

      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        ModelOtpCode data=   modelOtpCodeFromJson(str);
        login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());


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