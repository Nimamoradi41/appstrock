
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';

import '../../Constants.dart';
import '../Resident/Models/ModelNeetToCt.dart';






class ApiServiceTeriaz{
  static Future<ModelNeetToCt> AddPat (String Name,String codeMeli,String Age,String Gender,
      BuildContext context) async {
    var login;








    // id == 33





    var request = http.MultipartRequest('POST', Uri.parse('https://fmirzavand.ir/Patients'));
    request.fields.addAll({
      'FullName': Name,
      'NationalCode':codeMeli,
      'Age': Age,
      'GenderId': Gender,
      'InsertBy': '33'
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


}