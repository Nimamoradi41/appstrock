
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart'as http;
import 'package:appstrock/Screens/Autentication/Models/ModelRigester.dart';

import 'Models/ModelOtpCode.dart';

class ApiServiceAutentication{
  static Future<ModelRigester> Rigester(String Name,String Typeuser,String NationalCode,String PhoneNumber,BuildContext context) async{
    var login;


    final url = Uri.parse('Rigester');
    // final url = Uri.parse(Base+'/Sales');
    // final url = Uri.parse('http://172.10.10.186/AtiranKing/BankList');
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'Name': Name,
      'Typeuser': Typeuser,
      'NationalCode': NationalCode,
      'PhoneNumber': PhoneNumber,
    });




    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        showToast("مشکلی در ارتباط با سرور به وجود آمده",
            position: StyledToastPosition.top,
            context:context);
      }) ;
      Navigator.pop(context);
      if(response.statusCode==200)
      {


        String data=await response.stream.bytesToString();


        var DATA=data;


        // if(DATA.result==true)
        // {
        //   login= DATA;
        // }else{
        //
        //   login= DATA;
        // }
      }else{
        showToast("مشکلی در ارتباط با سرور به وجود آمده",
            position: StyledToastPosition.top,
            context:context);

      }
    }  on SocketException catch (e) {
      showToast("مشکلی در ارتباط با سرور به وجود آمده",
          position: StyledToastPosition.top,
          context:context);
      Navigator.pop(context);
    } on TimeoutException catch (e) {
      showToast("مشکلی در ارتباط با سرور به وجود آمده",
          position: StyledToastPosition.top,
          context:context);
      Navigator.pop(context);

    }












    // pr.hide();
    return login;
  }


  static Future<ModelOtpCode> CodeOtp(String Code,BuildContext context) async{
    var login;


    final url = Uri.parse('CodeOtp');
    // final url = Uri.parse(Base+'/Sales');
    // final url = Uri.parse('http://172.10.10.186/AtiranKing/BankList');
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'Code': Code,
    });




    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
      ).catchError((error) {
        showToast("مشکلی در ارتباط با سرور به وجود آمده",
            position: StyledToastPosition.top,
            context:context);
      }) ;
      Navigator.pop(context);
      if(response.statusCode==200)
      {


        String data=await response.stream.bytesToString();


        var DATA=data;


        // if(DATA.result==true)
        // {
        //   login= DATA;
        // }else{
        //
        //   login= DATA;
        // }
      }else{
        showToast("مشکلی در ارتباط با سرور به وجود آمده",
            position: StyledToastPosition.top,
            context:context);

      }
    }  on SocketException catch (e) {
      showToast("مشکلی در ارتباط با سرور به وجود آمده",
          position: StyledToastPosition.top,
          context:context);
      Navigator.pop(context);
    } on TimeoutException catch (e) {
      showToast("مشکلی در ارتباط با سرور به وجود آمده",
          position: StyledToastPosition.top,
          context:context);
      Navigator.pop(context);

    }












    // pr.hide();
    return login;
  }

}