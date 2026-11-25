import 'package:appstrock/Widgets/TextApp.dart';
import 'package:appstrock/report/model/ModelLogItemReport.dart';
import 'package:flutter/material.dart';

import '../Screens/Reception/ApiServiceReception.dart';
import 'BoxFirstRowReport.dart';
import 'model/BoxFirstRowLogReport.dart';

class LogFirstReportScreen extends StatefulWidget {

  late String name;
  late String id;

  LogFirstReportScreen(this.name,this.id);

  @override
  State<LogFirstReportScreen> createState() => _LogFirstReportScreenState();
}

class _LogFirstReportScreenState extends State<LogFirstReportScreen> {


  List<ModelLogItemReport> listLog=[];
  Future getLogs() async {


    var date = await ApiServiceReception.getLog(
        context,widget.id);
    if (date.success) {
      if (date.data!.isNotEmpty) {
        listLog=date.data!;
        setState(() {

        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogs();
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextApp("  نام بیمار :  ${widget.name} ",16,Colors.black87,true),
            ),
            Expanded  (
              child: Card(
                child: Column(
                  children: [
                    Container(
                      color: Colors.indigo[100],
                      padding: const EdgeInsets.symmetric(
                          vertical: 12),
                      child: const Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Center(
                                child: Text('زمان',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold)),
                              )),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text('نوع عملیات',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold)),
                              )),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text('رزیدنت',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold)),
                              )),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listLog.length,
                        itemBuilder: (context, index) {
                          var item = listLog[index];
                          return BoxFirstRowLogReport(
                              item.name,
                              item.activity,
                              item.time,
                              index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
