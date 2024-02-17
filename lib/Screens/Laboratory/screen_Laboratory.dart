import 'package:appstrock/Screens/Laboratory/ScreenLaboratoryDetailPatient.dart';
import 'package:appstrock/Screens/Reception/ApiServiceReception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../Constants.dart';
import '../../Widgets/ItemPatient.dart';
import '../../Widgets/TextApp.dart';
import '../Reception/Model/ModelPatient.dart';
import '../Reception/ProviderReception/ProviderReception.dart';




class ScreenLaboratory extends StatefulWidget {




  @override
  State<ScreenLaboratory> createState() => _ScreenLaboratoryState();
}

class _ScreenLaboratoryState extends State<ScreenLaboratory> {
  String  Name='';

  String Code='';

  late HubConnection connection;

  ScreenReception(bool IsRigester,BuildContext context,String NewName,String CodeNew){
    if(IsRigester)
    {
      ShowSuccesMsg(context, 'ثبت نام با موفقیت انجام شد');
      //Set an animation
    }


    Notifi.ListItemsPatient.add(ModelPatient(id: 7445, fullName: 'NimaMorado', nationalCode: '1788484', age: '32', gender: 'مرد', timeOfAddToSystem: '', dateOfAddToSystem: '', needToMRI: false, isNot724: false, needToCT: false, IsNIHSS: false, IsLab: false, timeOfAddLabotory: '', ResonNot: ''));
    // ignore: invalid_use_of_visible_for_testing_member
    Notifi.notifyListeners();
    // Notifi=Provider.of<ProviderReception>(context,listen: false);

    Name=NewName;
    Code=CodeNew;

    // try{
    //   connection=HubConnectionBuilder().withUrl('https://fmirzavand.ir/patientHub').build();
    //   connection.on('ReceivePatientUpdate', (arguments) {
    //     RunListP(context,false);
    //   });
    //   connection.start();
    // }catch (E)
    // {
    //   print(E.toString());
    // }

    // RunListP(context, true);
  }

  bool status=false;



  List<ModelPatient> ItemsP=[];

  var items = [
    'مرد',
    'زن',
  ];

  String dropdownvalue = 'مرد';

  late var Notifi=ProviderReception();

  Future RunListP(BuildContext context,bool refresh) async
  {
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    // چاپ تاریخ جلالی با فرمت مورد نظر
    print('تاریخ جلالی فعلی: $formattedDate');








    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ListPatient(formattedDate,context,refresh);





    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.setItems(Data.data);
      }else{
        showToast(Data.message,
            position: StyledToastPosition.top,
            context:context);
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    double hei=MediaQuery.of(context).size.height;
    wid=wid>600?600:wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: wid,
            height: double.infinity,
            color: BackGroundApp,
            child: Stack(
              children: [
                Container(
                  width: wid,
                  height: wid*0.25,
                  color: ColorApp,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 16,),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RotatedBox(
                              quarterTurns: 90,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.exit_to_app,color: Colors.white,size: 30,),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 0,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.person,color: Colors.white,size: 30,),
                              ),
                            ),
                            Expanded(child:
                            Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'آزمایشگاه',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                )

                              // TextApp('فوریت های پزشکی', 16, Colors.white, true),
                            )),
                          ],
                        ),
                      )
                    ],

                  ),
                ),
                Positioned(
                  top: wid*0.14,
                  right: 16,
                  left: 16,
                  child: Container(
                    width: wid*0.85,
                    child: Column(
                      children: [
                        Container(
                          decoration: MainDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 8,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Consumer<ProviderReception>(
                                        builder: (context,newstate,child){
                                          status=newstate.status;
                                          return FlutterSwitch(
                                            value: status,
                                            activeColor: Color(0xff38b000),
                                            onToggle: (val) {
                                              Notifi.setstatus(!status);
                                              // setState(() {
                                              //   status = val;
                                              // });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(child: TextApp2('وضعیت شیفت',16,ColorTextsubject,false)),
                                    SizedBox(width: 4 ,)
                                  ],

                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Container(
                          height:  hei*0.68,
                          child: Consumer<ProviderReception>(
                            builder: (context,newstate,child){
                              // ItemsP=newstate.ListItemsPatient;
                              return ListView.builder(
                                // itemCount: ItemsP.length,
                                itemCount: 2,
                                itemBuilder: (ctx,item){
                                  return InkWell(
                                    onTap: (){
                                       GoNextPage(context,
                                           ScreenLaboratoryDetailPatient(
                                           ModelPatient(id: 10, fullName: 'Ahmad Bagheri',
                                               nationalCode: '548548548484', age: '45',
                                               gender: 'مرد',
                                               timeOfAddToSystem: '14:20',
                                               dateOfAddToSystem: '1402/02/02',
                                               needToMRI: false,
                                               isNot724: false,
                                               needToCT: false,
                                           IsNIHSS: false, IsLab: false, timeOfAddLabotory: '', ResonNot: ''), context));
                                    },
                                    // child: ItemPatient(wid: wid, ItemsP: ItemsP[item],),
                                    child: ItemPatient(wid: wid),
                                  );
                                },
                              );
                            },

                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 8,
                    right: 8,
                    left: 8,
                    child: TextApp(VersionApp, 12, Colors.black54, true))
              ],
            ),
          ),
        ),
      ),
    );
  }
}





