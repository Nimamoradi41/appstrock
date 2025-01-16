
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:appstrock/Screens/Autentication/Models/ModelLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../Autentication/Models/ModelConst.dart';
import 'Models/ModelNeetToCt.dart';






class ApiServiceResident{
  static Future<ModelNeetToCt> NeedToCT(String id,BuildContext context) async {
    var login;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }


    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/NeedToCT'));
    request.fields.addAll({
      'id': id,
      'userId': UserId.toString(),
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


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/NeedToMRI'));
    request.fields.addAll({
      'id': id,
      'userId': UserId.toString(),
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


  static Future<ModelNeetToCt> AddNihs(String id,BuildContext context,List<Map<String, dynamic>> Str, int score)
  async {
    var login;



    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/AddNihsForm'));
    request.fields.addAll({
      'patientId': id,
      'userId': UserId.toString(),
      'N_1_a': Str[0]['selected_answer'].toString(),
      'N_1_b': Str[1]['selected_answer'].toString(),
      'N_1_c': Str[2]['selected_answer'].toString(),
      'N_2': Str[3]['selected_answer'].toString(),
      'N_3': Str[4]['selected_answer'].toString(),
      'N_4': Str[5]['selected_answer'].toString(),
      'N_5_a': Str[6]['selected_answer'].toString(),
      'N_5_b': Str[7]['selected_answer'].toString(),
      'N_6_a': Str[8]['selected_answer'].toString(),
      'N_6_b': Str[9]['selected_answer'].toString(),
      'N_7': Str[10]['selected_answer'].toString(),
      'N_8': Str[11]['selected_answer'].toString(),
      'N_9': Str[12]['selected_answer'].toString(),
      'N_10': Str[13]['selected_answer'].toString(),
      'N_11': Str[14]['selected_answer'].toString(),
      'subscore':score.toString(),
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

  static Future<ModelNeetToCt> editNihs(String id,BuildContext context,List<Map<String, dynamic>> Str, int score)
  async {
    var login;



    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/UpdateNihsForm'));
    request.fields.addAll({
      'patientId': id,
      'userId': UserId.toString(),
      'N_1_a': Str[0]['selected_answer'].toString(),
      'N_1_b': Str[1]['selected_answer'].toString(),
      'N_1_c': Str[2]['selected_answer'].toString(),
      'N_2': Str[3]['selected_answer'].toString(),
      'N_3': Str[4]['selected_answer'].toString(),
      'N_4': Str[5]['selected_answer'].toString(),
      'N_5_a': Str[6]['selected_answer'].toString(),
      'N_5_b': Str[7]['selected_answer'].toString(),
      'N_6_a': Str[8]['selected_answer'].toString(),
      'N_6_b': Str[9]['selected_answer'].toString(),
      'N_7': Str[10]['selected_answer'].toString(),
      'N_8': Str[11]['selected_answer'].toString(),
      'N_9': Str[12]['selected_answer'].toString(),
      'N_10': Str[13]['selected_answer'].toString(),
      'N_11': Str[14]['selected_answer'].toString(),
      'subscore':score.toString(),
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

  static Future<ModelNeetToCt> AddLab(String id,BuildContext context,List<Map<String, dynamic>> Str)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }


    var request = http.MultipartRequest('POST',Uri.parse('https://api.appstrok.ir/Patients/AddLabResult'));


    request.fields.addAll({
      'patientId': id,
      'userId': UserId.toString(),
      'BUN': Str[0]['selected_answer'].toString(),
      'Cr': Str[1]['selected_answer'].toString(),
      'PLT': Str[2]['selected_answer'].toString(),
      'PT': Str[3]['selected_answer'].toString(),
      'INR': Str[4]['selected_answer'].toString(),
      'hb': Str[5]['selected_answer'].toString(),
      'wbc': Str[6]['selected_answer'].toString(),
      'Trop': Str[7]['selected_answer'].toString()=='0'?'false':'true',
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















    return login;
  }


  static Future<ModelNeetToCt> editLab(String id,BuildContext context,List<Map<String, dynamic>> Str)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }


    var request = http.MultipartRequest('POST',Uri.parse('https://api.appstrok.ir/Patients/UpdateLabResult'));


    request.fields.addAll({
      'patientId': id,
      'userId': UserId.toString(),
      'BUN': Str[0]['selected_answer'].toString(),
      'Cr': Str[1]['selected_answer'].toString(),
      'PLT': Str[2]['selected_answer'].toString(),
      'PT': Str[3]['selected_answer'].toString(),
      'INR': Str[4]['selected_answer'].toString(),
      'hb': Str[5]['selected_answer'].toString(),
      'wbc': Str[6]['selected_answer'].toString(),
      'Trop': Str[7]['selected_answer'].toString()=='0'?'false':'true',
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















    return login;
  }

  static Future<ModelNeetToCt> AddbloodPressure(String id,BuildContext context,String bloodPressure1,String bloodPressure2)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }


    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/AddPatientSigns'));
    request.fields.addAll({
      'patientId': id,
      'userId': UserId.toString(),
      'bloodPressure1': bloodPressure1.toString(),
      'bloodPressure2': bloodPressure2.toString(),
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















    return login;
  }

  static Future<ModelNeetToCt> AddTimeinjection(String id,BuildContext context,String Time)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }


    var request = http.MultipartRequest('POST',Uri.parse('https://api.appstrok.ir/Patients/TimeOfInjection'));
    request.fields.addAll({
      'patientId': id,
      'userId': UserId.toString(),
      'Time': Time.toString(),
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

    return login;
  }


  static Future<ModelLogin> Set724(String idPa,BuildContext context,
      bool IsUnkown,String TimeStart,String DateStart
      ,String TimeFssStart,String DateFSSStart,String TimeLKWStart,
      String DateLKWStart,bool status, String timestamp,String timestampLKW,String timestampFSS)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/Set724Status'));
    request.fields.addAll({
      'id': idPa,
      'userId': UserId.toString(),
      'status': status.toString(),
      'isUnKnown': IsUnkown.toString(),
      'signsStartDate': DateStart,
      'signsStartTime': TimeStart,
      'fssTime': TimeFssStart,
      'fssDate': DateFSSStart,
      'lkwTime': TimeLKWStart,
      'lkwDate': DateLKWStart,
      'signsStartTS': timestamp,
    });

    if(IsUnkown)
      {

      }






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
        ModelLogin data = modelLoginFromJson(str);
        login = data;
          ShowErrorMsg(context, 'مشکلی در دریافت اطلاعات از سرور به وجود آمده');
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















    return login;
  }

  static Future<ModelLogin> SetNot724(String idPa,BuildContext context,
      bool status, String timestamp)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/Set724Status'));
    request.fields.addAll({
      'id': idPa,
      'userId': UserId.toString(),
      'status': status.toString(),
      'signsStartTS': timestamp,
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
        ModelLogin data = modelLoginFromJson(str);
        login = data;
        ShowErrorMsg(context, 'مشکلی در دریافت اطلاعات از سرور به وجود آمده');

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















    return login;
  }

  static Future<ModelLogin> PressBlod(String idPa,BuildContext context,String bloodPressure1,String bloodPressure2)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/AddPatientSigns'));
    request.fields.addAll({
      'patientId': idPa,
      'userId': UserId.toString(),
      'bloodPressure1': bloodPressure1.toString(),
      'bloodPressure2': bloodPressure2.toString(),
    });






    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        Navigator.pop(context);
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;



      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelLogin data= await  modelLoginFromJson(str);
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

  static Future<ModelLogin> Blod(String idPa,BuildContext context,String blood)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/AddPatientSigns'));
    request.fields.addAll({
      'patientId': idPa,
      'userId': UserId.toString(),
      'bs': blood.toString(),
    });






    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        Navigator.pop(context);
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;



      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelLogin data= await  modelLoginFromJson(str);
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

  static Future<ModelLogin> UploadImage(String idPa,BuildContext context,Uint8List Image,String nameFile)
  async {
    var login;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/AddImages'));
    request.fields.addAll({
      'patientId': idPa,
      'userId': UserId.toString(),
    });
    request.files.add(
      http.MultipartFile.fromBytes(
          'Images',
          Image,
          filename:nameFile),
    );


    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        Navigator.pop(context);
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;



      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelLogin data= await  modelLoginFromJson(str);
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




  static Future<ModelNeetToCt> TimeOfInjection(String idPa,BuildContext context,String Time, int timestamp)
  async {
    var login;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/TimeOfInjection'));

    request.fields.addAll({
      'patientId': idPa,
      'userId': UserId.toString(),
      'Time': Time,
      'injectionTimeTS': timestamp.toString(),
    });


  print(request.fields.toString());



    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;



      print(response.statusCode.toString());
      if(response.statusCode==200)
      {
        String str= await response.stream.bytesToString();
        print(str);
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        login=data;
      }
      if(response.statusCode==400)
      {
        String? strw= await response.reasonPhrase;
        String str= await response.stream.bytesToString();
        ModelNeetToCt data= await  modelNeetToCtFromJson(str);
        print(data.message.toString());
        login=data;
      }
      if(response.statusCode==403)
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















    return login;
  }


  static Future<ModelConst> Not724(String idPa,BuildContext context)
  async {
    var login;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/IsNot724'));
    request.fields.addAll({
      'id': idPa,
      'idUser': UserId.toString(),
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
  static Future<ModelLogin> ReasonsForIsNot724(String idPa,BuildContext context,bool MisdiagnosisOfTriage,
      bool MisdiagnosisOfEms,bool OverTime)
  async {
    var login;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.appstrok.ir/Patients/ReasonsForIsNot724'));

    request.fields.addAll({
      'patientId': idPa,
      'userId': UserId.toString(),
      'MisdiagnosisOfTriage':MisdiagnosisOfTriage.toString() ,
      'MisdiagnosisOfEms':MisdiagnosisOfEms.toString() ,
      'OverTime':OverTime.toString() ,
    });





    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        ShowErrorMsg(context,'مشکلی در ارتباط با سرور به وجود آمده');
      }) ;





      print(response.statusCode.toString());
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
        ModelLogin data= await  modelLoginFromJson(str);
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














    return login;
  }

}