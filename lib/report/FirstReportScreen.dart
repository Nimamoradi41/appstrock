import 'package:appstrock/Widgets/TextApp.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
class FirstReportScreen extends StatelessWidget {
  const FirstReportScreen({super.key});


  // فرض کن این دیتا از سرور اومده:
  List<Map<String, dynamic>> getPatientDataFromServer() {
    return [
      {
        'name': 'علی رضایی',
        'nationalCode': '1234567890',
        'medicine': 'آموکسی سیلین'
      },
      {
        'name': 'سمانه کریمی',
        'nationalCode': '0987654321',
        'medicine': 'آزیترومایسین'
      },
      {
        'name': 'بهمن نادری',
        'nationalCode': '1112223334',
        'medicine': 'قرص فشار'
      },
    ];
  }



  void generateExcelAndDownload() {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['بیماران'];

    // اضافه کردن هدرها
    sheet.appendRow(['نام بیمار', 'کد ملی', 'نوع دارو']);

    // اضافه کردن داده‌ها از سرور
    final patientList = getPatientDataFromServer();
    for (var patient in patientList) {
      sheet.appendRow([
        patient['name'],
        patient['nationalCode'],
        patient['medicine'],
      ]);
    }

    // تولید فایل اکسل
    final excelBytes = excel.encode();
    if (excelBytes == null) return;

    // آماده‌سازی برای دانلود در وب
    final blob = html.Blob([excelBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'patients.xlsx')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final patients = List.generate(50, (index) => 'نیما');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(
                Icons.calendar_today_outlined, color: Colors.black),
            onPressed: () {
              generateExcelAndDownload();
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(child: Text(
                'فروردین ۱۴۰۴', style: TextStyle(color: Colors.black))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
        child: Column(
          children: [
            Card(
              color: Colors.indigo[50],
              child: ListTile(
                title: const  Text('25') ,
                trailing: const Text(': تعداد بیمارانی که وارد سیستم شده‌اند'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.indigo[50],
              child: ListTile(
                title: const Text('25'),
                trailing: const Text(': تعداد بیمارانی که تزریق انجام شده است') ,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    Container(
                      color: Colors.indigo[100],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:  Center(
                                child: Text('زریدنت', style: TextStyle(
                                fontWeight: FontWeight.bold)),
                              )),
                          Expanded(
                              flex: 2,
                              child:  Center(
                                child: Text('دارو', style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                              )),
                          Expanded(
                              flex: 2,
                              child:  Center(
                                child: Text('بیمار', style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
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
                                          onPressed: () {},
                                          child: const Text('مشاهده'),
                                        ),
                                      )),
                                  const Expanded(
                                      flex: 2,
                                      child:  Center(
                                        child: Text('مورفین'),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child:  TextApp(patients[index],14,Colors.black,true)),
                                ],
                              ),
                            ),
                          );
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