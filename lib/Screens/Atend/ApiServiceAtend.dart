
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:appstrock/Screens/Atend/model/ModelImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';

import '../../Constants.dart';
import '../Resident/Models/ModelNeetToCt.dart';







class ApiServiceAtend{
  static Future<ModelNeetToCt> NeedToCT(String id,BuildContext context,String signsStartTime) async {
    var login;


    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Patients/NeedToCT'));
    request.fields.addAll({
      'id': id,
      'signsStartTime': signsStartTime,
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

  static Future<ModelNeetToCt> NeedToMRI(String id,BuildContext context,String signsStartTime) async {
    var login;


    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Patients/NeedToMRI'));
    request.fields.addAll({
      'id': id,
      'signsStartTime': signsStartTime,
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



  static Future<ModelImages> GetPatientImages(String id,BuildContext context) async {
    var login;





    var request = http.MultipartRequest('POST', Uri.parse('https://api.appstrok.ir/Patients/GetPatientImages'));
    request.fields.addAll({
      'id': id
     });


    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str= await response.stream.bytesToString();
      login=   modelImagesFromJson(str);
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
    else {
      print(response.reasonPhrase);
    }

    return login;
  }









}