import 'package:appstrock/report/ProviderFirstReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../Screens/Atend/ScreenFormMedicalInjection.dart';
import '../Screens/Reception/ApiServiceReception.dart';
import 'BoxFirstHeaderReport.dart';
import 'BoxFirstRowReport.dart';

class FirstReportScreen extends StatefulWidget {
  const FirstReportScreen({super.key});

  @override
  State<FirstReportScreen> createState() => _FirstReportScreenState();
}

class _FirstReportScreenState extends State<FirstReportScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver  {


  Future getReport() async {
    // provider.setLoading(true);
    provider.modelFirstReport.data?.medicinePatient.clear();
    provider.modelFirstReport.data?.countInjection=0;
    provider.modelFirstReport.data?.count724=0;
    provider.modelFirstReport.data?.countPatient=0;

    var date = await ApiServiceReception.firstReport(
        context, formattedDateFrom, formattedDateTo);
    if (date.success) {
      if (date.data!.medicinePatient.isNotEmpty) {
        provider.setItems(date);
      } else {
        provider.setLoading(false);
      }
    }
  }

  String formattedDateFrom = '';
  String formattedDateTo = '';

  late var provider = ProviderFirstReport();
  Jalali? dateFrom;
  Jalali? dateTo;

  Future persianDateCalenderFrom() async {
    Jalali? pickedFrom = await showPersianDatePicker(
      context: context,
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
      initialDate: dateFrom == null ? Jalali.now() : dateFrom!!,
    );
    dateFrom = pickedFrom;

    if (pickedFrom != null) {
      formattedDateFrom = '${dateFrom?.year}/${dateFrom?.month.toString().padLeft(2, '0')}/${dateFrom?.day.toString().padLeft(2, '0')}';
      setState(() {});
    }
  }

  Future persianDateCalenderTo() async {
    Jalali? pickedTo = await showPersianDatePicker(
      context: context,
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
      initialDate: dateTo == null ? Jalali.now() : dateTo!!,
    );
    dateTo = pickedTo;

    if (pickedTo != null) {
      formattedDateTo =
          '${dateTo?.year}/${dateTo?.month.toString().padLeft(2, '0')}/${dateTo?.day.toString().padLeft(2, '0')}';
      setState(() {});
      getReport();
    }
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ProviderFirstReport>(context, listen: false);

    Jalali date = Jalali.now();
    formattedDateFrom =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';

    formattedDateTo = formattedDateFrom;

    getReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  persianDateCalenderTo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(formattedDateTo,
                        style: TextStyle(color: Colors.black)),
                    SizedBox(
                      width: 4.0,
                    ),
                    RotatedBox(
                      quarterTurns: 90,
                      child: SvgPicture.asset(
                        'assets/Svg/datefrom.svg',
                        height: 25,
                        width: 25,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: () {
                  // setInjectionTrue("s",context);
                  persianDateCalenderFrom();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(formattedDateFrom,
                        style: TextStyle(color: Colors.black)),
                    SizedBox(
                      width: 4.0,
                    ),
                    SvgPicture.asset(
                      'assets/Svg/datefrom.svg',
                      height: 25,
                      width: 25,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 8),
                      child: Consumer<ProviderFirstReport>(
                        builder: (context, provider, child) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              BoxFirstHeaderReport(
                                  provider.modelFirstReport!.data!.countPatient
                                      .toString(),
                                  'تعداد بیمارانی که وارد سیستم شده است'),
                              const SizedBox(
                                height: 8,
                              ),
                              BoxFirstHeaderReport(
                                  provider.modelFirstReport!.data!.count724
                                      .toString(),
                                  'تعداد بیمارانی که کد 724 دارند'),
                              const SizedBox(
                                height: 8,
                              ),
                              BoxFirstHeaderReport(
                                  provider
                                      .modelFirstReport!.data!.countInjection
                                      .toString(),
                                  'تعداد بیمارانی که تزریق شده است'),
                              const SizedBox(
                                height: 8,
                              ),
                              Expanded(
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
                                                  child: Text('رزیدنت',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Center(
                                                  child: Text('دارو',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Center(
                                                  child: Text('بیمار',
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
                                          itemCount: provider.modelFirstReport!
                                              .data?.medicinePatient.length,
                                          itemBuilder: (context, index) {
                                            var item = provider
                                                .modelFirstReport!
                                                .data
                                                ?.medicinePatient[index];
                                            return BoxFirstRowReport(
                                                item!.patientName,
                                                item.medicine,
                                                item.patientId,
                                                index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ))

    );
  }
}


// provider.isLoading && provider.modelFirstReport.data!.medicinePatient.isEmpty
// ? const Center(child: CircularProgressIndicator())
//     : !provider.isLoading && provider.modelFirstReport.data!.medicinePatient.isEmpty
// ? const Center(
// child: Text("محتوایی برای نمایش وجود ندارد"),
// )
//     : !provider.isLoading && provider.modelFirstReport.data!.medicinePatient.isNotEmpty