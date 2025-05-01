
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

  static Future<ModelListPatient> PatientListBetweenDate(String dateFrom,String dateTo,BuildContext context) async {
    var login;
    var request = http.MultipartRequest('POST', Uri.parse('https://api.appstrok.ir/Patients/PatientListBetweenDate'));
    request.fields.addAll({
      'startDate': dateFrom,
      'endDate': dateTo,
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

  static Future<ModelLogin> editProfile(String id,String name,String code,String age,String gender,BuildContext context) async {
    var login;



    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }



    var request = http.MultipartRequest('POST', Uri.parse('https://api.appstrok.ir/Patients/Edit'));
    request.fields.addAll({
      'Id': id,
      'FullName': name,
      'NationalCode': code,
      'Age': age,
      'GenderId': gender,
      'UpdateBy': UserId.toString()
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


    } on Error catch (e) {
      print(e.toString());
      ShowErrorMsg(context, 'مشکلی در ارتباط با سرور به وجود آمده');
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


    var request = http.MultipartRequest('POST', Uri.parse('https://api.appstrok.ir/Patients/SetInjectionStatus'));
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

  static Future<ModelLogin> SetInjectionReason(BuildContext context,String patientId,List<Map<String, dynamic>> Str) async {
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
      'UserId': UserId.toString(),
      'Description': "test",
      'Status': "false",
      'IsReason': "true",
      'C1': Str[0]['selected_answer'].toString(),
      'C2': Str[1]['selected_answer'].toString(),
      'C3': Str[2]['selected_answer'].toString(),
      'C4': Str[3]['selected_answer'].toString(),
      'C5': Str[4]['selected_answer'].toString(),
      'C6': Str[5]['selected_answer'].toString(),
      'C7': Str[6]['selected_answer'].toString(),
      'C8': Str[7]['selected_answer'].toString(),
      'C9': Str[8]['selected_answer'].toString(),
      'C10': Str[9]['selected_answer'].toString(),
      'C11': Str[10]['selected_answer'].toString(),
      'C12': Str[11]['selected_answer'].toString(),
      'C13': Str[12]['selected_answer'].toString(),
      'C14': Str[13]['selected_answer'].toString(),
      'C15': Str[14]['selected_answer'].toString(),
      'C16': Str[15]['selected_answer'].toString(),
      'C17': Str[16]['selected_answer'].toString(),
      'C18': Str[17]['selected_answer'].toString(),
      'C19': Str[18]['selected_answer'].toString(),
      'C20': Str[19]['selected_answer'].toString(),
      'C21': Str[20]['selected_answer'].toString(),
      'C22': Str[21]['selected_answer'].toString(),
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
      }
      if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelLogin data=   modelLoginFromJson(str);
        login=data;
      }

      else{
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