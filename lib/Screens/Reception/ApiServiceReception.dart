
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:appstrock/Screens/Autentication/Models/ModelLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../Autentication/Models/ModelChangeshift.dart';
import 'Model/ModelListPatient.dart';





class ApiServiceReception{
  static Future<ModelListPatient> ListPatient(String Date,BuildContext context) async {
    var login;
    var request = http.MultipartRequest('POST', Uri.parse('https://api.appstrok.ir/Patients/PatientList'));
    request.fields.addAll({
      'date': Date,
      // 'date': '1402/11/02',
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
        print(str);
        ModelListPatient data= await  modelListPatientFromJson(str);
        login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      print(e.toString());
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }














    return login;
  }
  static Future<ModelListPatient> ListPatientLab(String Date,BuildContext context) async {
    var login;
    var request = http.MultipartRequest('POST', Uri.parse('https://api.appstrok.ir/Patients/PatientForAttend'));
    request.fields.addAll({
      'date': Date,
    });
    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      });
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str.toString());
        ModelListPatient data= await  modelListPatientFromJson(str);
        login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      print(e.toString());
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }














    return login;
  }

  static Future<ModelChangeshift> ChangeShiftStatus(BuildContext context) async {
    var login;


    var UserId="-1";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('UserId')!=null)
      {
        UserId=prefs.getString('UserId')!;
      }


    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Users/ChangeShiftStatus'));
    request.fields.addAll({
      'id': UserId,
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
        print(str);
        ModelChangeshift data= await  modelLoginFromJsonModelChangeshift(str);
        login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      print(e.toString());
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }


    return login;
  }

  static Future<ModelLogin> SeenByAtend(BuildContext context,String patientId ) async {
    var login;


    var UserId="-1";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }


    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/SeenByAttend'));
    request.fields.addAll({
      'patientId': patientId,
      'userId': UserId.toString(),
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
        print(str);
        ModelLogin data= await  modelLoginFromJson(str);
        login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      print(e.toString());
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }


    return login;
  }

  static Future<ModelLogin> SetInjectionStatus(BuildContext context,String patientId,bool status) async {
    var login;


    var UserId="-1";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }


    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/SetInjectionStatus'));
    request.fields.addAll({
      'id': patientId,
      'userId': UserId.toString(),
      'status': status.toString(),
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
        print(str);
        ModelLogin data= await  modelLoginFromJson(str);
        login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      print(e.toString());
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }


    return login;
  }

  static Future<ModelListPatient> PatientForAttend(String Date,BuildContext context,bool refresh) async {
    var login;


    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Patients/PatientList'));
    request.fields.addAll({
      'date': Date,
      // 'date': '1402/11/02',
    });


    print(request.fields.toString());
    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;


      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelListPatient data= await  modelListPatientFromJson(str);
        login=data;
      }else{
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      print(e.toString());
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }














    return login;
  }





}