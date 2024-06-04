import 'dart:async';

import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // late Jalali ja;
  // late Timer _timer;
  //
  //
  // double FinalTime=0;
  // void startTimer() {
  //   const oneSec =   Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //           FinalTime=FinalTime+1;
  //           final time = Duration(seconds: FinalTime.toInt());
  //           print(time.toString());
  //     },
  //   );
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Jalali date=Jalali.now().formatter;
    // var Expi=Jalali(1403,02,20,19,0,0);
    // DateTime now = new DateTime.now();
    // // print(ss.toDateTime().millisecondsSinceEpoch.toString());
    // print((now.millisecondsSinceEpoch/1000));
    // print((Expi.toDateTime().millisecondsSinceEpoch/1000));
    //
    // FinalTime=((now.millisecondsSinceEpoch/1000)-(Expi.toDateTime().millisecondsSinceEpoch/1000));
    // startTimer();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Column(
         children: [
           TextApp('adva', 16, Colors.black45, true)
         ],
       ),
     ),
   );
  }
}



