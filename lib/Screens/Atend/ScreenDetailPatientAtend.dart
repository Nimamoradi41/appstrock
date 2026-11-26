import 'dart:async';

import 'package:appstrock/Screens/Atend/ScreenListImages.dart';
import 'package:appstrock/Screens/Atend/ScreenFormMedicalInjection.dart';
import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormTimeInjection.dart';
import 'package:appstrock/Screens/Resident/ScreenFormReasonInjection.dart';
import 'package:appstrock/Screens/Resident/ProviderResident/ProviderTimers.dart';
import 'package:appstrock/features/patients/ui/attend/attend_review_page.dart';
import 'package:appstrock/features/patients/ui/attend/patient_residents_screen.dart';
import 'package:appstrock/features/patients/ui/resident/patient_image_upload_screen.dart';
import 'package:appstrock/features/patients/ui/resident/laboratory_screen.dart';
import 'package:appstrock/features/patients/ui/resident/nihss_screen.dart';
import 'package:appstrock/features/patients/ui/resident/patient_vitals_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../SignalRService.dart';
import '../../core/AppConfig.dart';
import '../../features/patients/data/resident_patient_repository.dart';
import '../Reception/ApiServiceReception.dart';
import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'ProviderAtend/ProviderAtendDetaile.dart';




class ScreenDetailPatientAtend extends StatefulWidget {
  ScreenDetailPatientAtend(this.patientItem,this.MainCtx,this.formattedDateFrom,this.formattedDateTo);
  ModelPatient patientItem;
  BuildContext MainCtx;
  String formattedDateFrom;
  String formattedDateTo;
  @override
  State<ScreenDetailPatientAtend> createState() => _ScreenDetailPatientState();
}
class _ScreenDetailPatientState extends State<ScreenDetailPatientAtend> with WidgetsBindingObserver {


  Future NeedToCT(BuildContext context) async {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceResident.NeedToCT(widget.patientItem.id.toString(),context);
    Navigator.pop(context);
    if(Data.success)
    {
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      getInfoOfPatient();
    }else{
      // ignore: use_build_context_synchronously
      ShowErrorMsg(context, Data.message);
    }
  }
  Future NeedToMRI(BuildContext context) async {

    ShowLoadingApp(context);

    // ignore: use_build_context_synchronously
    var Data= await ApiServiceResident.NeedToMRI(widget.patientItem.id.toString(),context);

    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  String    Convert_Time(String Hour,String Minute,String Seconds) {
    var temp_Hour="";
    var temp_Min="";
    var temp_Seconds="";
    if (Hour.length==1)
    {
      temp_Hour="0"+Hour;
    }else{
      temp_Hour=Hour;
    }
    if (Minute.length==1)
    {
      temp_Min="0"+Minute;
    }else{
      temp_Min=Minute;
    }

    if (Seconds.length==1)
    {
      temp_Seconds="0"+Seconds;
    }else{
      temp_Seconds=Seconds;
    }
    return  ("$temp_Hour:$temp_Min:$temp_Seconds").toString();


  }

  Future editNIHS(List<Map<String, dynamic>> Str,int score)async {

    ShowLoadingApp(context);
    var Data= await ApiServiceResident.editNihs(widget.patientItem.id.toString(),
        context,Str,score);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future AddNIHS(List<Map<String, dynamic>> Str,int score)async {

    ShowLoadingApp(context);
    var Data= await ApiServiceResident.AddNihs(widget.patientItem.id.toString(), context,Str,score);

    if(Data.success)
    {
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      getInfoOfPatient();
    }else{
      // ignore: use_build_context_synchronously
      ShowErrorMsg(context, Data.message);
    }


  }

  Future   seenByAtend(String id,BuildContext context) async {
    ShowLoadingApp(context);
    var Data= await ApiServiceReception.SeenByAtend(context,widget.patientItem.id.toString());


    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

    Navigator.pop(context);

  }

  Future   setInjectionTrue(String id,BuildContext context) async {

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
                  child: ScreenFormMedicalInjection((pa) async {
                    // ignore: use_build_context_synchronously
                    ShowLoadingApp(context);
                    var Data= await ApiServiceReception.SetInjectionStatus(context,widget.patientItem.id.toString(),true,pa[0]['selected_answer'].toString());

                    Navigator.pop(context);

                    if(Data!=null)
                    {
                      if(Data.success)
                      {
                        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
                        getInfoOfPatient();
                      }else{
                        // ignore: use_build_context_synchronously
                        ShowErrorMsg(context, Data.message);
                      }
                    }


                  },0)),
            ],
          );
        });


  }

  Future   setInjectionReason(String id,BuildContext context,List<Map<String, dynamic>> Str) async
  {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.SetInjectionReason(context,widget.patientItem.id.toString(),Str);
    print(Data.toJson());

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

    Navigator.pop(context);
  }
  Future   setInjectionFalse(String id,BuildContext context) async
  {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.SetInjectionStatus(context,widget.patientItem.id.toString(),false,'0');
    print(Data.toJson());

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
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

  Duration _elapsedTime = Duration.zero;

  late var Notifi=ProviderAtendDetaile();
  // var TimeEffect=0.0;
  var TimeTaInjection=0.0;
  var TimeTaInjectionStr='0';
  var TimeEffectStr="0";
  var TimeAriveToHospital=0.0;
  var TimeAriveToHospitalStr="0";
  Timer? _timer;
  double FinalTime=0;
  double FinalTime2=0;
  Duration _elapsedTimeFss = Duration.zero;
  Duration _elapsedTimeArriveToHospital = Duration.zero;
   late DateTime TimeEffect;
  Future RequestAddTimeInjection(String Time,String timeStamp ,String medicene) async {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data = await ApiServiceResident.TimeOfInjection(
        widget.patientItem.id.toString(), context, Time, timeStamp.toString(),medicene);
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
                        pa[0]['selected_answer'].toString(),pa[1]['selected_answer'].toString(),pa[2]['selected_answer'].toString());
                  },Notifi.patientItem.medicine!,true)),
            ],
          );
        });
  }

  void _formatElapsedTimeFss() {
    int hours = _elapsedTimeFss.inHours;
    int minutes = _elapsedTimeFss.inMinutes % 60;
    int seconds = _elapsedTimeFss.inSeconds % 60;

    providerTimer.updateTimerSymptomRecognition(
        "${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }

  void startTimer() {
    const oneSec =   Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {


        if( Notifi.patientItem.signsStartTS!=0)
        {
          var date=DateTime.fromMillisecondsSinceEpoch(Notifi.patientItem.signsStartTS!!);
          _elapsedTime   = DateTime.now().difference(date);
          _formatElapsedTime();
        }

        if(Notifi.patientItem.signsStartTSFSS!=0)
        {
          var date=DateTime.fromMillisecondsSinceEpoch(Notifi.patientItem.signsStartTSFSS!!);

          _elapsedTimeFss   = DateTime.now().difference(date);

          _formatElapsedTimeFss();
        }

        if (Notifi.patientItem.insertTimeTS != 0) {
          var date = DateTime.fromMillisecondsSinceEpoch(Notifi.patientItem.insertTimeTS!!);

          _elapsedTimeArriveToHospital = DateTime.now().difference(date);

          _formatElapsedTimeArriveToHospital();
        }

      },
    );
  }

  void _formatElapsedTimeArriveToHospital() {
    int hours = _elapsedTimeArriveToHospital.inHours;
    int minutes = _elapsedTimeArriveToHospital.inMinutes % 60;
    int seconds = _elapsedTimeArriveToHospital.inSeconds % 60;
    providerTimer.updateTimerArriveToHospital(
        "${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }
  AddReasonInjection(){
    showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (ctx){
          return  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child:   ScreenFormReasonInjection((pa)
                  async{
                    // AddResean(pa[0]['selected_answer']!,
                    //     pa[1]['selected_answer']!,
                    //     pa[2]['selected_answer']!);
                  },Notifi.patientItem.notInjectingIsComplete!,
                      Notifi.patientItem.c1!,
                      Notifi.patientItem.c2!,
                      Notifi.patientItem.c3!,
                      Notifi.patientItem.c4!,
                      Notifi.patientItem.c5!,
                      Notifi.patientItem.c6!,
                      Notifi.patientItem.c7!,
                      Notifi.patientItem.c8!,
                      Notifi.patientItem.c9!,
                      Notifi.patientItem.c10!,
                      Notifi.patientItem.c11!,
                      Notifi.patientItem.c12!,
                      Notifi.patientItem.c13!,
                      Notifi.patientItem.c14!,
                      Notifi.patientItem.c15!,
                      Notifi.patientItem.c16!,
                      Notifi.patientItem.c17!,
                      Notifi.patientItem.c18!,
                      Notifi.patientItem.c19!,
                      Notifi.patientItem.c20!,
                      Notifi.patientItem.c21!,
                      Notifi.patientItem.c22!
                  )),
            ],
          );

        });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SignalRService().isPageActive = false;
    SignalRService().disconnect();

    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      print("❌ تایمر متوقف شد");
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


  late ProviderTimers providerTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);



    providerTimer = Provider.of<ProviderTimers>(context, listen: false);
    Notifi = Provider.of<ProviderAtendDetaile>(context, listen: false);


    getInfoOfPatient();

    var connect=SignalRService();
    // اتصال اولیه
    connect.initConnection();

    connect.onMessageReceived = () {
      getInfoOfPatient();
    };

  }

  Future RunPressBload(String Blod1,String Blod2)async{

    ShowLoadingApp(context);

    var Data= await ApiServiceResident.PressBlod(widget.patientItem.id.toString()
        ,context,Blod1,Blod2);

    Navigator.pop(context);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

  }

  Future RunBload(String Blod)async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.Blod(widget.patientItem.id.toString(),context,Blod);

    Navigator.pop(context);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }


  }

  Future reset()async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.reset(widget.patientItem.id.toString(),context);

    Navigator.pop(context);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Navigator.pop(context);
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  bool isLoading=true;

  bool isTimerRunning() {
    return _timer != null && _timer!.isActive;
  }

  Future<void> getInfoOfPatient() async {
    if (!mounted) return;
    setState(() => isLoading = true);
    try {
      final patient = await _recordRepository.getPatient(
          patientId: widget.patientItem.id,
          from: widget.formattedDateFrom,
          to: widget.formattedDateTo);
      if (!mounted) return;
      Notifi.setItems(patient);
      _hasLoaded = true;
      Notifi.setLoading(false);
      if (patient.isFinished != true) {
        if (!isTimerRunning()) startTimer();
      } else {
        _timer?.cancel();
      }
    } catch (error) {
      if (mounted) ShowErrorMsg(context, error.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future AddLab(List<Map<String, dynamic>> Str)async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.AddLab(widget.patientItem.id.toString(),context,Str);
    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();

      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future editLab(List<Map<String, dynamic>> Str)async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.editLab(widget.patientItem.id.toString(),context,Str);
    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  Future changeTM()async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.changeTM(widget.patientItem.id.toString(),context);
    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  @override
  final _recordRepository = ResidentPatientRepository();
  bool _hasLoaded = false;

  ModelPatient get _patient =>
      _hasLoaded ? Notifi.patientItem : widget.patientItem;

  Future<void> _openNihss() async {
    final patient = _patient;
    final saved = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => NihssScreen(
        patient: patient,
        onSubmit: (answers, score) => _recordRepository.saveNihss(
            widget.patientItem.id.toString(), answers, score,
            update: patient.nihsIsComplete),
      ),
    ));
    if (saved == true && mounted) {
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      getInfoOfPatient();
    }
  }

  Future<void> _openLaboratory() async {
    final patient = _patient;
    final saved = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => LaboratoryScreen(
        patient: patient,
        onSubmit: (answers) => _recordRepository.saveLab(
            widget.patientItem.id.toString(), answers,
            update: patient.labIsComplete),
      ),
    ));
    if (saved == true && mounted) {
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      getInfoOfPatient();
    }
  }

  Future<void> _openVitals(PatientVital vital) async {
    final patient = _patient;
    final saved = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => PatientVitalsScreen(
        patient: patient,
        vital: vital,
        onSubmit: (first, second) => vital == PatientVital.bloodPressure
            ? _recordRepository.saveBloodPressure(
                widget.patientItem.id.toString(), first, second!)
            : _recordRepository.saveBloodSugar(
                widget.patientItem.id.toString(), first),
      ),
    ));
    if (saved == true && mounted) {
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      getInfoOfPatient();
    }
  }

  Future<void> _toggleMT() async {
    if (!_hasLoaded) return;
    ShowLoadingApp(context);
    final result =
        await _recordRepository.changeMT(widget.patientItem.id.toString());
    if (!mounted) return;
    Navigator.pop(context);
    if (result.success) {
      getInfoOfPatient();
    } else {
      ShowErrorMsg(context, result.message);
    }
  }

  Future<void> _toggleCT() async {
    if (!_hasLoaded) return;
    ShowLoadingApp(context);
    final result =
        await _recordRepository.needToCT(widget.patientItem.id.toString());
    if (!mounted) return;
    Navigator.pop(context);
    if (result.success) {
      getInfoOfPatient();
    } else {
      ShowErrorMsg(context, result.message);
    }
  }

  Future<void> _toggleMRI() async {
    if (!_hasLoaded) return;
    ShowLoadingApp(context);
    final result =
        await _recordRepository.needToMRI(widget.patientItem.id.toString());
    if (!mounted) return;
    Navigator.pop(context);
    if (result.success) {
      getInfoOfPatient();
    } else {
      ShowErrorMsg(context, result.message);
    }
  }

  Future<void> _markSeen() async {
    ShowLoadingApp(context);
    final result = await ApiServiceReception.SeenByAtend(
        context, widget.patientItem.id.toString());
    if (!mounted) return;
    Navigator.pop(context);
    if (result != null && result.success) {
      ShowSuccesMsg(context, 'مشاهده بیمار ثبت شد');
      getInfoOfPatient();
    } else {
      ShowErrorMsg(context, result?.message ?? 'ثبت مشاهده ناموفق بود');
    }
  }

  Future<bool> _saveDecision(bool inject, int medication) async {
    final result = await _recordRepository.saveInjectionDecision(
        widget.patientItem.id.toString(), inject, medication);
    if (!mounted) return false;
    if (!result.success) {
      ShowErrorMsg(context, result.message);
      return false;
    }
    getInfoOfPatient();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final patient = _patient;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffeaf0f7),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: const Color(0xfffbfcfe),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x220f2943),
                          blurRadius: 14,
                          offset: Offset(0, 5))
                    ]),
                child: AttendReviewPage(
                    patient: patient,
                    refreshing: isLoading,
                    onBack: () => Navigator.pop(context),
                    onSeen: _markSeen,
                    onImages: () => GoNextPage(
                        context,
                        ScreenListImages(
                            widget.patientItem.id.toString())),
                    onNihss: _openNihss,
                    onLaboratory: _openLaboratory,
                    onResidents: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PatientResidentsScreen(patient: patient))),
                    onBloodPressure: () =>
                        _openVitals(PatientVital.bloodPressure),
                    onBloodSugar: () =>
                        _openVitals(PatientVital.bloodSugar),
                    onNeedCT: _toggleCT,
                    onNeedMRI: _toggleMRI,
                    onUpload: () => GoNextPage(context, PatientImageUploadScreen(
                      name: patient.fullName, age: patient.age, nationalCode: patient.nationalCode,
                      gender: patient.gender, patientId: patient.id.toString())),
                    onSaveDecision: _saveDecision,
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
