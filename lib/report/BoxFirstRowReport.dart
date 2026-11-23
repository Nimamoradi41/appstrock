import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Widgets/TextApp.dart';
import 'FirstReportScreen.dart';
import 'LogFirstreportScreen.dart';

class BoxFirstRowReport extends StatelessWidget {

  String patientName;
  int medicine;
  int patientId;
  int index;


  BoxFirstRowReport(this.patientName, this.medicine, this.patientId,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 == 0 ? Colors.grey[50] : Colors
          .grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child:  Center(
                  child:  TextButton(
                    onPressed: () {
                      GoNextPage(context, LogFirstReportScreen(patientName,patientId.toString()));

                    },
                    child: const Text('مشاهده'),
                  ),
                )),
              Expanded(
                flex: 2,
                child:  Center(
                  child: Text(medicine==1
                      ? 'آلتپلاز':
                  medicine==2
                      ? 'تنکتپلاز':'آلتلایز(ایرانی)',),
                )),
            Expanded(
                flex: 2,
                child:  TextApp(patientName,14,Colors.black,true)),
          ],
        ),
      ),
    );
  }
}
