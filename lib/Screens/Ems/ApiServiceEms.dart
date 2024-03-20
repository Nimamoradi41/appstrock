
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import 'ModelAddPatient.dart';



class ApiServiceEms{
  static Future<ModelAddPatient> AddPatient(String FullName,
      String Date,
      String NationalCode,
      String Age,
      int GenderId,
      BuildContext context) async {
    var login;


    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Patients'));



    SharedPreferences prefs = await SharedPreferences.getInstance();
     String? UserId=   prefs.getString('UserId');

    // UserId

    request.fields.addAll({
      'FullName': FullName,
      'Date': Date,
      'NationalCode': NationalCode,
      'Age': Age,
      'GenderId': GenderId.toString(),
      'InsertBy': UserId.toString()
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
        ModelAddPatient data= await  modelAddPatientFromJson(str);
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