
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:appstrock/Screens/Autentication/Models/ModelLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';

import '../../Constants.dart';
import '../Autentication/Models/ModelConst.dart';
import 'Models/ModelNeetToCt.dart';






class ApiServiceResident{
  static Future<ModelNeetToCt> NeedToCT(String id,BuildContext context) async {
    var login;


    var request = http.MultipartRequest('POST',
        Uri.parse('https://fmirzavand.ir/Patients/NeedToCT'));
    request.fields.addAll({
      'id': id,
      'idUser': '33',
    });




    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;


      print(response.statusCode.toString());
      print(response.reasonPhrase.toString());
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        login=data;
      }else {
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }














    return login;
  }

  static Future<ModelNeetToCt> NeedToMRI(String id,BuildContext context)
  async {
    var login;


    var request = http.MultipartRequest('POST',
        Uri.parse('https://fmirzavand.ir/Patients/NeedToMRI'));
    request.fields.addAll({
      'id': id,
      'idUser': '33',
    });




    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;



      print(response.statusCode.toString());
      print(response.reasonPhrase.toString());
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        login=data;
      }
      if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        login=data;
      }
      else {
        ShowErrorMsg(context,response.reasonPhrase.toString());
      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }














    Navigator.pop(context);
    return login;
  }


  static Future<ModelNeetToCt> AddNihs(String id,BuildContext context,List<Map<String, dynamic>> Str)
  async {
    var login;


    var request = http.MultipartRequest('POST',
        Uri.parse('https://fmirzavand.ir/Patients/AddNihsForm'));
    request.fields.addAll({
      'patientId': id,
      'userId': '33',
      '_1_a': Str[0]['selected_answer'].toString(),
      '_1_b': Str[1]['selected_answer'].toString(),
      '_1_c': Str[2]['selected_answer'].toString(),
      '_2': Str[3]['selected_answer'].toString(),
      '_3': Str[4]['selected_answer'].toString(),
      '_4': Str[5]['selected_answer'].toString(),
      '_5_a': Str[6]['selected_answer'].toString(),
      '_5_b': Str[7]['selected_answer'].toString(),
      '_6_a': Str[8]['selected_answer'].toString(),
      '_6_b': Str[9]['selected_answer'].toString(),
      '_7': Str[10]['selected_answer'].toString(),
      '_8': Str[11]['selected_answer'].toString(),
      '_9': Str[12]['selected_answer'].toString(),
      '_10': Str[13]['selected_answer'].toString(),
      '_11': Str[14]['selected_answer'].toString(),
    });



    print(request.fields.toString());


    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;


      print(response.statusCode.toString());
      print(response.reasonPhrase.toString());
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        login=data;
      }
      if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        login=data;
      }else {
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }














    Navigator.pop(context);
    return login;
  }


  static Future<ModelNeetToCt> Set724(String idPa,BuildContext context,
      bool IsUnkown,String TimeStart,String DateStart
      ,String TimeFssStart,String DateFSSStart,String TimeLKWStart,String DateLKWStart,bool status)
  async {
    var login;


    var request = http.MultipartRequest('POST',
        Uri.parse('https://fmirzavand.ir/Patients/Set724Status'));
    request.fields.addAll({
      'id': idPa,
      'userId': '33',
      'status': status.toString(),
      'isUnKnown': IsUnkown.toString(),
      'signsStartDate': DateStart,
      'signsStartTime': TimeStart,
      'fssTime': TimeFssStart,
      'fssDate': DateFSSStart,
      'lkwTime': TimeLKWStart,
      'lkwDate': DateLKWStart,
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
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        login=data;
      }else {
        ShowErrorMsg(context,response.reasonPhrase.toString());

      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }















    return login;
  }


  static Future<ModelConst> Not724(String idPa,BuildContext context)
  async {
    var login;


    var request = http.MultipartRequest('POST',
        Uri.parse('https://fmirzavand.ir/Patients/IsNot724'));
    request.fields.addAll({
      'id': idPa,
      'idUser': '33',
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
        ModelConst data= await  modelLoginFromJsonModelConst(str);
        login=data;
      }else {
        ShowErrorMsg(context,response.reasonPhrase.toString());
      }
    }  on SocketException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');

    } on TimeoutException catch (e) {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');


    } on Error catch (e)
    {
      ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
    }














    return login;
  }









}