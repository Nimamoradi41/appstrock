import 'dart:async';

import 'package:appstrock/Screens/Laboratory/ScreenFormLaboratory.dart';
import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormBload724.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:appstrock/Screens/Resident/ScreenFormTimeInjection.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants.dart';
import '../../SignalRService.dart';
import '../../Widgets/TextApp.dart';
import '../../components/BoxInformation.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/Model/ModelPatient.dart';
import '../WebImagePicker.dart';
import 'ProviderResident/ProviderResidentDetaile.dart';
import 'ProviderResident/ProviderTimers.dart';
import 'ScreenFormIs724.dart';
import 'ScreenFormIsNot724.dart';
import 'ScreenFormPreesBload724.dart';
import 'ScreenFormReasonInjection.dart';

class ScreenDetailPatient extends StatefulWidget {
  ScreenDetailPatient(this.patientItem, this.MainCtx, this.formattedDateFrom,this. formattedDateTo);

  ModelPatient patientItem;
  BuildContext MainCtx;
  String formattedDateFrom;
  String formattedDateTo;

  @override
  State<ScreenDetailPatient> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenDetailPatient>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late var Notifi = ProviderResidentDetaile();

  // Future NeedToCT(BuildContext context)async{
  Future NeedToCT(BuildContext context) async {
    DateTime? TimeStart;
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data = await ApiServiceResident.NeedToCT(
        widget.patientItem.id.toString(), context);
    if (Data.success) {
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      getInfoOfPatient();
    } else {
      // ignore: use_build_context_synchronously
      ShowErrorMsg(context, Data.message);
    }
  }

  Future NeedToMRI(BuildContext context) async {
    ShowLoadingApp(context);

    // ignore: use_build_context_synchronously
    var Data = await ApiServiceResident.NeedToMRI(
        widget.patientItem.id.toString(), context);

    if (Data.success) {
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      getInfoOfPatient();
    } else {
      // ignore: use_build_context_synchronously
      ShowErrorMsg(context, Data.message);
    }
  }

  Future AddNIHS(List<Map<String, dynamic>> Str, int score) async {
    ShowLoadingApp(context);
    var Data = await ApiServiceResident.AddNihs(
        widget.patientItem.id.toString(), context, Str, score);

    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future editNIHS(List<Map<String, dynamic>> Str, int score) async {
    ShowLoadingApp(context);
    var Data = await ApiServiceResident.editNihs(
        widget.patientItem.id.toString(), context, Str, score);

    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future IsNot724() async {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var Data = await ApiServiceResident.SetNot724(
        widget.patientItem.id.toString(), context, false, timestamp.toString());
    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future AddResean(
      bool MisdiagnosisOfTriage, bool MisdiagnosisOfEms, bool OverTime) async {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously

    var Data = await ApiServiceResident.ReasonsForIsNot724(
        widget.patientItem.id.toString(),
        context,
        MisdiagnosisOfTriage,
        MisdiagnosisOfEms,
        OverTime);
    Navigator.pop(context);
    Navigator.pop(context);
    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  AddReasonNot724() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ScreenFormIsNot724((pa) async {
                    AddResean(pa[0]['selected_answer']!,
                        pa[1]['selected_answer']!, pa[2]['selected_answer']!);
                  },
                      Notifi.patientItem.isNot724IsComplete!,
                      Notifi.patientItem.misdiagnosisOfTriage!,
                      Notifi.patientItem.misdiagnosisOfEms!,
                      Notifi.patientItem.overTime!)),
            ],
          );
        });
  }

  Future setInjectionReason(
      String id, BuildContext context, List<Map<String, dynamic>> Str) async {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data = await ApiServiceReception.SetInjectionReason(
        context, widget.patientItem.id.toString(), Str);


    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }


    Navigator.pop(context);
  }

  void _formatElapsedTime() {
    int hours = _elapsedTime.inHours;
    int minutes = _elapsedTime.inMinutes % 60;
    int seconds = _elapsedTime.inSeconds % 60;
    providerTimer.updateTimerSymptomOnset(
        "${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }

  void _formatElapsedTimeArriveToHospital() {
    int hours = _elapsedTimeArriveToHospital.inHours;
    int minutes = _elapsedTimeArriveToHospital.inMinutes % 60;
    int seconds = _elapsedTimeArriveToHospital.inSeconds % 60;
    providerTimer.updateTimerArriveToHospital(
        "${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }

  void _formatElapsedTimeFss() {
    int hours = _elapsedTimeFss.inHours;
    int minutes = _elapsedTimeFss.inMinutes % 60;
    int seconds = _elapsedTimeFss.inSeconds % 60;
    providerTimer.updateTimerSymptomRecognition(
        "${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }

  Duration _elapsedTimeArriveToHospital = Duration.zero;
  Duration _elapsedTime = Duration.zero;
  Duration _elapsedTimeFss = Duration.zero;
  late DateTime TimeEffect;

  Future AddRequestIs724(
      bool IsUnkown,
      String TimeStart,
      String DateStart,
      String TimeFssStart,
      String DateFSSStart,
      String TimeLKWStart,
      String DateLKWStart,
      String timestamp,
      String timestampLKW,
      String timestampFSS) async {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data = await ApiServiceResident.Set724(
        widget.patientItem.id.toString(),
        context,
        IsUnkown,
        TimeStart,
        DateStart,
        TimeFssStart,
        DateFSSStart,
        TimeLKWStart,
        DateLKWStart,
        true,
        timestamp,
        timestampLKW,
        timestampFSS);
    Navigator.pop(context);
    Navigator.pop(context);
    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Add724() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (ctx) {
          return Container(
              margin: EdgeInsets.only(top: 16),
              child: ScreenFormIs724((p) async {
                var Know = p[0]['Know'];
                String Time = '';
                String TimeFss = '';
                String TimeLKW = '';
                String Date = '';
                String DateFSS = '';
                String DateLKW = '';
                String timestamp = '';
                Navigator.pop(context);
                ShowLoadingApp(context);
                await Future.delayed(Duration(seconds: 2));
                if (Know == 'false') {
                  Time = p[1]['Time']!;
                  Date = p[2]['Date']!;
                  timestamp = p[3]['timestamp']!;
                  print(Time);
                  print(Date);
                  print(timestamp);
                  AddRequestIs724(
                      false, Time, Date, '', '', '', '', timestamp, '', '');
                } else {
                  TimeFss = p[3]['TimeFss']!;
                  TimeLKW = p[1]['TimeLKW']!;
                  DateFSS = p[4]['DateFss']!;
                  DateLKW = p[2]['DateLKW']!;
                  var timestampLKW = p[5]['timestampLKW']!;
                  var timestampFSS = p[6]['timestampFSS']!;
                  AddRequestIs724(true, '', '', TimeFss, DateFSS, TimeLKW,
                      DateLKW, timestamp, timestampLKW, timestampFSS);
                }
              }));
        });
  }

  Timer? _timer;

  // var TimeEffect=0.0;
  // var TimeTaInjection=0.0;

  var TimeTaInjectionStr = '0';
  var TimeEffectStr = "0";
  var TimeAriveToHospital = 0.0;
  var TimeAriveToHospitalStr = "0";

  String Convert_Time(String Hour, String Minute, String Seconds) {
    var temp_Hour = "";
    var temp_Min = "";
    var temp_Seconds = "";
    if (Hour.length == 1) {
      temp_Hour = "0$Hour";
    } else {
      temp_Hour = Hour;
    }
    if (Minute.length == 1) {
      temp_Min = "0$Minute";
    } else {
      temp_Min = Minute;
    }

    if (Seconds.length == 1) {
      temp_Seconds = "0$Seconds";
    } else {
      temp_Seconds = Seconds;
    }
    return ("$temp_Hour:$temp_Min:$temp_Seconds").toString();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (Notifi.patientItem.isFinished!) {
          _timer!.cancel();
        }

        if (Notifi.patientItem.signsStartTS != 0) {
          var date = DateTime.fromMillisecondsSinceEpoch(
              Notifi.patientItem.signsStartTS!!);

          _elapsedTime = DateTime.now().difference(date);

          _formatElapsedTime();
        }

        if (Notifi.patientItem.insertTimeTS != 0) {
          var date = DateTime.fromMillisecondsSinceEpoch(
              Notifi.patientItem.insertTimeTS!!);

          _elapsedTimeArriveToHospital = DateTime.now().difference(date);

          _formatElapsedTimeArriveToHospital();
        }

        if (Notifi.patientItem.signsStartTSFSS != 0) {
          var date = DateTime.fromMillisecondsSinceEpoch(Notifi.patientItem.signsStartTSFSS!!);

          _elapsedTimeFss = DateTime.now().difference(date);

          _formatElapsedTimeFss();
        }

        // Notifi.setTimeAriveToHospital(TimeAriveToHospitalStr);
      },
    );
  }

  late ProviderTimers providerTimer;

  Future RunPressBload(String Blod1, String Blod2) async {
    ShowLoadingApp(context);

    var Data = await ApiServiceResident.PressBlod(
        widget.patientItem.id.toString(), context, Blod1, Blod2);

    Navigator.pop(context);

    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future AddLab(List<Map<String, dynamic>> Str) async {
    ShowLoadingApp(context);
    var Data = await ApiServiceResident.AddLab(
        widget.patientItem.id.toString(), context, Str);
    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future editLab(List<Map<String, dynamic>> Str) async {
    ShowLoadingApp(context);
    var Data = await ApiServiceResident.editLab(
        widget.patientItem.id.toString(), context, Str);
    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  var isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    providerTimer = Provider.of<ProviderTimers>(context, listen: false);
    Notifi = Provider.of<ProviderResidentDetaile>(context, listen: false);



    getInfoOfPatient();

    var connect=SignalRService();
    // اتصال اولیه
    connect.initConnection();

    connect.onMessageReceived = () {
      getInfoOfPatient();
    };
  }

  Future RunBload(String Blod) async {
    ShowLoadingApp(context);
    var Data = await ApiServiceResident.Blod(
        widget.patientItem.id.toString(), context, Blod);

    Navigator.pop(context);

    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future RequestAddTimeInjection(String Time,String timeStamp ) async {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data = await ApiServiceResident.TimeOfInjection(
        widget.patientItem.id.toString(), context, Time, timeStamp.toString());
    Navigator.pop(context);
    if (Data != null) {
      if (Data.success) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future uploadImage(String idPa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String UserId = '';

    // UserId

    if (prefs.getString('UserId') != null) {
      UserId = prefs.getString('UserId')!;
    }


    GoNextPage(context, WebImagePicker(Notifi.patientItem.fullName,Notifi.patientItem.age,Notifi.patientItem.nationalCode,Notifi.patientItem.gender,Notifi.patientItem.id.toString()));


    // // UserID 2
    // // idPa 26
    //
    // print('UserID ' +UserId);
    // print('idPa ' +idPa);
    // final String url = 'https://Upload.appstrok.ir/UploadFile?UserId=$UserId&PatientId=$idPa';
    //
    // // const url = 'https://web.appstrok.ir/UploadFile?UserId=$UserId&PatientId='+86;
    //
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  AddTimeInjection() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ScreenFormTimeInjection((pa) async {
                    RequestAddTimeInjection(
                        pa[0]['selected_answer'].toString(),pa[1]['selected_answer'].toString());
                  })),
            ],
          );
        });
  }

  bool isTimerRunning() {
    return _timer != null && _timer!.isActive;
  }

  Future getInfoOfPatient() async {
    isLoading = true;
    setState(() {});

    Jalali date = Jalali.now();


    // ignore: use_build_context_synchronously
    var Data = await ApiServiceReception.PatientListBetweenDate(widget.formattedDateFrom,widget.formattedDateTo, context);

    if (Data != null) {
      if (Data.success) {
        var finded = Data.data
            .firstWhere((element) => element.id == widget.patientItem.id);
        Notifi.setItems(finded);
        isLoading = false;
        setState(() {});

        if (!Notifi.patientItem.isFinished!) {
          if(!isTimerRunning())
          {
            startTimer();
          }
        } else {
          if (_timer != null) {
            _timer!.cancel();
          }
        }
      } else {
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SignalRService().isPageActive = false;
    SignalRService().disconnect();

    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!SignalRService().isPageActive)
      return; // ❗ اگه صفحه بسته شده، هیچ کاری نکن

    if (state == AppLifecycleState.resumed) {
      print('صفحه برگشته به حالت فعال');
      SignalRService().initConnection();
    } else if (state == AppLifecycleState.paused) {
      print('صفحه رفته بک‌گراند');
      SignalRService().disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    wid = wid > 600 ? 600 : wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Container(
                  width: wid,
                  height: double.infinity,
                  color: BackGroundApp,
                  child: Stack(
                    children: [
                      Container(
                        width: wid,
                        height: wid * 0.25,
                        color: ColorApp,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 16, right: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (_timer != null) {
                                          _timer!.cancel();
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        getInfoOfPatient();
                                      },
                                      child: Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Notifi.patientItem.is724IsComplete! &&
                                                !Notifi.patientItem.isNot724
                                            ? Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      TextApp(
                                                          Notifi.patientItem!
                                                                  .seenByAttend!
                                                              ? 'دکتر متخصص مشاهده کرده است'
                                                              : 'دکتر متخصص مشاهده نکرده است',
                                                          10,
                                                          Notifi.patientItem!
                                                                  .seenByAttend!
                                                              ? Colors.green
                                                              : Colors.red,
                                                          true),
                                                      SizedBox(
                                                        width: 2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        const Spacer(),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'اطلاعات بیمار',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )

                                            // TextApp('فوریت های پزشکی', 16, Colors.white, true),
                                            ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: wid * 0.14,
                        right: 16,
                        left: 16,
                        child: Container(
                          width: wid * 0.85,
                          height: hei * 0.88,
                          child: Column(
                            children: [
                              Container(
                                decoration: MainDecoration,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              TextApp('کدملی', 10,
                                                  ColorTitleText, false),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              TextApp(
                                                  Notifi.patientItem
                                                          .nationalCode.isEmpty
                                                      ? 'نامشخص'
                                                      : Notifi.patientItem
                                                          .nationalCode,
                                                  12,
                                                  ColorTextbody,
                                                  true)
                                            ],
                                          )),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            width: 1,
                                            height: 25,
                                            color: Colors.black12,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              TextApp('نام و نام خانوادگی', 10,
                                                  ColorTitleText, false),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              TextApp(
                                                  Notifi.patientItem.fullName
                                                          .isEmpty
                                                      ? 'نامشخص'
                                                      : Notifi
                                                          .patientItem.fullName,
                                                  12,
                                                  ColorTextbody,
                                                  true)
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              TextApp('سن', 12, ColorTitleText,
                                                  false),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              TextApp(
                                                  Notifi.patientItem.age.isEmpty
                                                      ? 'نامشخص'
                                                      : Notifi.patientItem.age,
                                                  14,
                                                  ColorTextbody,
                                                  true)
                                            ],
                                          )),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            width: 1,
                                            height: 25,
                                            color: Colors.black12,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              TextApp('جنسیت', 12,
                                                  ColorTitleText, false),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              TextApp(
                                                  Notifi.patientItem.gender
                                                          .isEmpty
                                                      ? 'نامشخص'
                                                      : Notifi
                                                          .patientItem.gender,
                                                  14,
                                                  ColorTextbody,
                                                  true)
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: MainDecoration,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              BoxInformation(
                                                  value: Notifi
                                                          .patientItem
                                                          .timeOfAddToSystem
                                                          .isEmpty
                                                      ? 'نامشخص'
                                                      : Notifi.patientItem
                                                          .timeOfAddToSystem,
                                                  title:
                                                      ' :  زمان ثبت در سیستم'),

                                              Notifi.patientItem.isFinished == false
                                                  ? Consumer<ProviderTimers>(
                                                      builder: (context,
                                                          provider, child) {
                                                        return BoxInformation(
                                                            value: provider
                                                                .timerArriveToHospital,
                                                            title:
                                                                ' :  تایمر بر اساس زمان ثبت در سیستم');
                                                      },
                                                    )
                                                  : Container(),


                                              Notifi.patientItem.is724IsComplete! &&
                                                  !Notifi.patientItem.isFinished! &&
                                                      Notifi.patientItem.signsStartTime!.isNotEmpty &&
                                                      Notifi.patientItem.signsStartTSFSS == 0
                                                  ? Consumer<ProviderTimers>(
                                                      builder: (context,
                                                          provider, child) {
                                                        return Column(
                                                          children: [
                                                            BoxInformation(
                                                                value: provider
                                                                    .timerTimerSymptomOnset,
                                                                title:
                                                                    ' :  تایمر بر اساس زمان شروع علائم'),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : Container(),
                                              Notifi.patientItem
                                                          .is724IsComplete! &&
                                                      !Notifi.patientItem
                                                          .isFinished! &&
                                                      Notifi.patientItem
                                                              .signsStartTSFSS !=
                                                          0
                                                  ? Consumer<ProviderTimers>(
                                                      builder: (context,
                                                          provider, child) {
                                                        return BoxInformation(
                                                            value: provider
                                                                .timerSymptomRecognition,
                                                            title:
                                                                ' :  تایمر بر اساس دیدن علائم');
                                                      },
                                                    )
                                                  : Container(),

                                              Consumer<ProviderResidentDetaile>(
                                                builder:
                                                    (context, provider, child) {
                                                  return Column(
                                                    children: [
                                                      BoxInformation(
                                                          value: Notifi
                                                                      .patientItem
                                                                      .dateOfAddToSystem ==
                                                                  null
                                                              ? 'نامشخص'
                                                              : Notifi
                                                                  .patientItem
                                                                  .dateOfAddToSystem!,
                                                          title:
                                                              ' :  تاریخ ثبت در سیستم'),
                                                      Notifi
                                                              .patientItem
                                                              .signsStartTime!
                                                              .isNotEmpty
                                                          ? BoxInformation(
                                                              value:
                                                                  "${Notifi.patientItem.signsStartTime} "
                                                                  "${Notifi.patientItem.signsStartDate} ",
                                                              title:
                                                                  ' :  زمان و تاریخ شروع علائم ')
                                                          : Container(),
                                                      Notifi
                                                              .patientItem
                                                              .dateFinishShamsi!
                                                              .isNotEmpty
                                                          ? BoxInformation(
                                                              value:
                                                                  "${Notifi.patientItem.dateFinishShamsi} "
                                                                  "${Notifi.patientItem.timeFinish} ",
                                                              title:
                                                                  ' :  زمان و تاریخ پایان کار ')
                                                          : Container(),
                                                      Notifi.patientItem
                                                                  .needToCT ||
                                                              Notifi.patientItem
                                                                  .needToMRI
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                      .patientItem
                                                                      .needToCT
                                                                  ? 'CTScan'
                                                                  : 'MRI',
                                                              title:
                                                                  ' :  وضعیت')
                                                          : Container(),
                                                      Notifi.patientItem
                                                                  .isNot724 ==
                                                              false
                                                          ? BoxInformation(
                                                              value: !Notifi
                                                                      .patientItem
                                                                      .nihsIsComplete!
                                                                  ? 'تکمیل نشده است'
                                                                  : Notifi
                                                                      .patientItem
                                                                      .nihsSubscore
                                                                      .toString(),
                                                              title:
                                                                  ' :  وضعیت  NIHSS',
                                                              onTap: () {
                                                                GoNextPage(
                                                                    context,
                                                                    ScreenFormNIHS(
                                                                      (p0, s) {

                                                                        if(Notifi.patientItem.is724IsComplete==false)
                                                                        {
                                                                          return ;
                                                                        }

                                                                        if (Notifi
                                                                            .patientItem
                                                                            .nihsIsComplete) {
                                                                          editNIHS(
                                                                              p0,
                                                                              s);
                                                                        } else {
                                                                          AddNIHS(
                                                                              p0,
                                                                              s);
                                                                        }
                                                                      },
                                                                      Notifi
                                                                          .patientItem
                                                                          .nihsIsComplete,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_1_a,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_1_b,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_1_c,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_2,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_3,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_4,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_5_a,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_5_b,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_6_a,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_6_b,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_7,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_8,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_9,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_10,
                                                                      Notifi
                                                                          .patientItem
                                                                          .n_11,
                                                                      false,
                                                                      Notifi
                                                                          .patientItem
                                                                          .nihsSubscore,
                                                                    ));
                                                              },
                                                            )
                                                          : Container(),
                                                      Notifi.patientItem
                                                                      .signsStartTSFSS !=
                                                                  0 &&
                                                              Notifi
                                                                  .patientItem
                                                                  .lkwDate
                                                                  .isNotEmpty
                                                          ? BoxInformation(
                                                              value:
                                                                  "${Notifi.patientItem.lkwDate} ${Notifi.patientItem.lkwTime}",
                                                              title: ' :  LKW')
                                                          : Container(),
                                                      Notifi.patientItem
                                                                  .injectionType !=
                                                              0
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                          .patientItem
                                                                          .injectionType ==
                                                                      1
                                                                  ? 'تزریق بشود'
                                                                  : 'تزریق نشود',
                                                              title:
                                                                  ' :  وضعیت تزریق')
                                                          : Container(),
                                                      Notifi.patientItem
                                                                  .isNot724 ==
                                                              false
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                          .patientItem
                                                                          .labIsComplete ==
                                                                      null
                                                                  ? 'تکمیل نشده است'
                                                                  : Notifi.patientItem
                                                                          .labIsComplete!
                                                                      ? 'تکمیل شده است'
                                                                      : 'تکمیل نشده است',
                                                              title:
                                                                  ' :  فرم آزمایشگاه',
                                                              onTap: () {
                                                                if (Notifi
                                                                        .patientItem
                                                                        .is724IsComplete ==
                                                                    true) {
                                                                  GoNextPage(
                                                                      context,
                                                                      ScreenFormLaboratory(
                                                                          (p0) {
                                                                        Navigator.pop(
                                                                            context);
                                                                        if (Notifi
                                                                            .patientItem
                                                                            .labIsComplete) {
                                                                          editLab(
                                                                              p0);
                                                                        } else {
                                                                          AddLab(
                                                                              p0);
                                                                        }
                                                                      },
                                                                          Notifi
                                                                              .patientItem
                                                                              .labIsComplete,
                                                                          Notifi
                                                                              .patientItem
                                                                              .bun
                                                                              .toString(),
                                                                          Notifi
                                                                              .patientItem
                                                                              .cr
                                                                              .toString(),
                                                                          Notifi
                                                                              .patientItem
                                                                              .plt
                                                                              .toString(),
                                                                          Notifi
                                                                              .patientItem
                                                                              .pt
                                                                              .toString(),
                                                                          Notifi
                                                                              .patientItem
                                                                              .inr
                                                                              .toString(),
                                                                          Notifi
                                                                              .patientItem
                                                                              .trop
                                                                              .toString(),
                                                                          Notifi
                                                                              .patientItem
                                                                              .hb
                                                                              .toString(),
                                                                          Notifi
                                                                              .patientItem
                                                                              .wbc
                                                                              .toString(),
                                                                          false));
                                                                }
                                                              },
                                                            )
                                                          : Container(),
                                                      Notifi.patientItem
                                                              .labIsComplete!
                                                          ? BoxInformation(
                                                              value:
                                                                  "${Notifi.patientItem.labInsertDate} - "
                                                                  "${Notifi.patientItem.labInsertTime}",
                                                              title:
                                                                  ' : زمان ثبت  فرم آزمایشگاه')
                                                          : Container(),
                                                      Notifi.patientItem
                                                                  .isNot724 ==
                                                              false
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                          .patientItem
                                                                          .bs ==
                                                                      0
                                                                  ? 'تکمیل نشده است'
                                                                  : Notifi
                                                                      .patientItem
                                                                      .bs
                                                                      .toString(),
                                                              title:
                                                                  ' :  قند خون',
                                                              onTap: () {
                                                                if (Notifi
                                                                        .patientItem
                                                                        .is724IsComplete ==
                                                                    true) {
                                                                  GoNextPage(
                                                                      context,
                                                                      ScreenFormBload724(
                                                                          Notifi
                                                                              .patientItem
                                                                              .id
                                                                              .toString(),
                                                                          false,
                                                                          (p0) {
                                                                        var item =
                                                                            p0[0]['bload'].toString();
                                                                        RunBload(
                                                                            item);
                                                                      }));
                                                                }
                                                              },
                                                            )
                                                          : Container(),
                                                      Notifi.patientItem
                                                                  .isNot724 ==
                                                              false
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                          .patientItem
                                                                          .bloodPressure1 ==
                                                                      0
                                                                  ? 'تکمیل نشده است'
                                                                  : "${Notifi.patientItem.bloodPressure1}/${Notifi.patientItem.bloodPressure2}",
                                                              title:
                                                                  ' :  فشار خون',
                                                              onTap: () {
                                                                if (Notifi
                                                                        .patientItem
                                                                        .is724IsComplete ==
                                                                    true) {
                                                                  GoNextPage(
                                                                      context,
                                                                      ScreenFormPreesBload724(
                                                                          Notifi
                                                                              .patientItem
                                                                              .id
                                                                              .toString(),
                                                                          false,
                                                                          (p0) {
                                                                        var bload1 =
                                                                            p0[0]['bload1'].toString();
                                                                        var bload2 =
                                                                            p0[0]['bload2'].toString();
                                                                        RunPressBload(
                                                                            bload1,
                                                                            bload2);
                                                                      }));
                                                                }
                                                              },
                                                            )
                                                          : Container(),
                                                      Notifi.patientItem
                                                                  .isNot724 ==
                                                              false
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                      .patientItem
                                                                      .timeOfInjection!
                                                                      .isEmpty
                                                                  ? 'تکمیل نشده است'
                                                                  : Notifi
                                                                      .patientItem
                                                                      .timeOfInjection
                                                                      .toString(),
                                                              title:
                                                                  ' :  زمان تزریق',
                                                              onTap: () {
                                                                if (Notifi.patientItem.timeOfInjection!.isEmpty &&
                                                                    Notifi.patientItem.is724IsComplete!) {
                                                                  AddTimeInjection();
                                                                }
                                                              },
                                                            )
                                                          : Container(),
                                                      Notifi.patientItem.otn
                                                              .isEmpty
                                                          ? Container()
                                                          : BoxInformation(
                                                              value: Notifi
                                                                  .patientItem
                                                                  .otn,
                                                              title: ' :  OTN'),
                                                      Notifi.patientItem.dtn
                                                              .isNotEmpty
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                  .patientItem
                                                                  .dtn,
                                                              title: ' :  DTN')
                                                          : Container(),
                                                      Notifi.patientItem.ftn
                                                              .isNotEmpty
                                                          ? BoxInformation(
                                                              value: Notifi
                                                                  .patientItem
                                                                  .ftn,
                                                              title: ' :  FTN')
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      !Notifi.patientItem.is724IsComplete! &&
                                              !Notifi.patientItem.isNot724!
                                          ? Row(
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        IsNot724();
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      ColorApp),
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .all(4)),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'کد 724 نیست',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )),
                                                )),
                                                Expanded(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Add724();
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      ColorApp),
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .all(4)),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ))),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'کد 724 است',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )),
                                                ))
                                              ],
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(),
                                      Container(
                                        width: wid,
                                        margin: const EdgeInsets.all(4),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              uploadImage(Notifi.patientItem.id
                                                  .toString());
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        ColorApp),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.all(4)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ))),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'آپلود عکس',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                      ),
                                      Notifi.patientItem.injectionType == 2
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          GoNextPage(
                                                              context,
                                                              ScreenFormReasonInjection(
                                                                (p0) {
                                                                  setInjectionReason(
                                                                      widget
                                                                          .patientItem
                                                                          .id
                                                                          .toString(),
                                                                      context,
                                                                      p0);
                                                                },
                                                                Notifi.patientItem
                                                                            .injectionType !=
                                                                        0
                                                                    ? true
                                                                    : false,
                                                                Notifi
                                                                    .patientItem
                                                                    .c1!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c2!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c3!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c4!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c5!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c6!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c7!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c8!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c9!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c10!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c11!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c12!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c13!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c14!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c15!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c16!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c17!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c18!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c19!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c20!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c21!,
                                                                Notifi
                                                                    .patientItem
                                                                    .c22!,
                                                              ));
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        ColorApp),
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all(EdgeInsets
                                                                        .all(
                                                                            4)),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            !Notifi.patientItem
                                                                    .notInjectingIsComplete!!
                                                                ? 'ثبت دلایل رد تزریق'
                                                                : 'نمایش دلایل رد تزریق',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      Notifi.patientItem.is724IsComplete! &&
                                              Notifi.patientItem.isNot724!
                                          ? Container(
                                              width: wid,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    AddReasonNot724();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor: !Notifi
                                                              .patientItem
                                                              .isNot724IsComplete!
                                                          ? MaterialStateProperty.all(
                                                              ColorApp)
                                                          : MaterialStateProperty.all(
                                                              Colors.white),
                                                      padding: MaterialStateProperty.all(
                                                          EdgeInsets.all(4)),
                                                      shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(!Notifi
                                                              .patientItem
                                                              .isNot724IsComplete!
                                                          ? RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            )
                                                          : RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(8.0),
                                                              side: const BorderSide(color: ColorApp, width: 2)))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      Notifi.patientItem
                                                                  .isNot724IsComplete ==
                                                              null
                                                          ? 'تکمیل دلایل رد کد 724'
                                                          : Notifi.patientItem
                                                                  .isNot724IsComplete!
                                                              ? 'نمایش دلایل رد کد 724'
                                                              : 'تکمیل دلایل رد کد 724',
                                                      style: TextStyle(
                                                          color: Notifi
                                                                      .patientItem
                                                                      .isNot724IsComplete ==
                                                                  null
                                                              ? Colors.white
                                                              : Notifi.patientItem
                                                                      .isNot724IsComplete!
                                                                  ? ColorApp
                                                                  : Colors
                                                                      .white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )),
                                            )
                                          : Container(),
                                      Notifi.patientItem.is724IsComplete! &&
                                              !Notifi.patientItem.isNot724
                                          ? const Row(
                                              children: [],
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

}
