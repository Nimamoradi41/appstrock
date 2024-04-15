
import 'package:appstrock/Screens/Ems/ApiServiceEms.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../Constants.dart';
import '../Reception/screen_reception.dart';
import 'ProviderEms/ProviderEms.dart';

 class ScreenEms extends StatefulWidget {




   @override
  State<ScreenEms> createState() => _ScreenEmsState();
}

class _ScreenEmsState extends State<ScreenEms> {
   bool status=false;

   var items = [
     'مرد',
     'زن',
   ];

   late var Notifi=ProviderEms();
   Future RunAddP(BuildContext context)async{
     if(TextConName.text.isEmpty)
     {
       showToast("نام و نام خانوادگی را وارد کنید",
           position: StyledToastPosition.top,
           context:context);
       return;
     }


     Jalali date=Jalali.now();
     String formattedDate =
         '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
     // چاپ تاریخ جلالی با فرمت مورد نظر
     print('تاریخ جلالی فعلی: $formattedDate');
     ShowLoadingApp(context);
     var Data=await ApiServiceEms.AddPatient(TextConName.text,formattedDate,TextConCode.text.toString(),
         TextConAge.text.toString(),Notifi.dropdownvalue=='مرد'?2:1,context);




     if(Data!=null)
     {
       if(Data.success)
       {
         // Ok Shode
         TextConAge.clear();
         TextConCode.clear();
         TextConName.clear();
         TextConGender.clear();
         Notifi.Refrsh();
         ShowSuccesMsg(context,'بیمار با موفقیت ثبت شد');
       }else{
         ShowErrorMsg(context, Data.message);
       }
     }






   }

   var TextConName=TextEditingController();

   var TextConCode=TextEditingController();

   var TextConAge=TextEditingController();

   var TextConGender=TextEditingController();

   Future   ChangShift(bool StatusNew,BuildContext context) async
   {
    var Flag=await ShowAllow(context,'آیا از تغییر شیفت خود مطمئن هستید ؟');
    if(Flag)
      {
        ShowLoadingApp(context);
        var Data=await ApiServiceEms.ChangeShiftStatus(context);
        if(Data!=null)
        {
          if(Data.success)
          {
            Notifi.setstatus(StatusNew);
            ShowSuccesMsg(context,'بیمار با موفقیت ثبت شد');
          }else{
            ShowErrorMsg(context, Data.message);
          }
        }





      }
   }
   @override
  void initState() {
    super.initState();
    // if(widget.IsRigester)
    // {
    //   ShowSuccesMsg(context, 'ثبت نام با موفقیت انجام شد');
    //   //Set an animation
    // }
  }
   @override
   Widget build(BuildContext context) {
     Notifi=Provider.of<ProviderEms>(context);
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
                   child:   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(width: 16,),
                       Expanded(
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.end,
                           children:   [
                             InkWell(
                               onTap: () {
                                 SystemNavigator.pop();
                               } ,
                               child: const RotatedBox(
                                 quarterTurns: 90,
                                 child: Padding(
                                   padding: EdgeInsets.all(16.0),
                                   child: Icon(Icons.exit_to_app,color: Colors.white,size: 30,),
                                 ),
                               ),
                             ),
                             const RotatedBox(
                               quarterTurns: 0,
                               child: Padding(
                                 padding: EdgeInsets.all(16.0),
                                 child: Icon(Icons.person,color: Colors.white,size: 30,),
                               ),
                             ),
                             const Expanded(child:
                             Padding(
                                 padding: EdgeInsets.all(16.0),
                                 child: Text(
                                   'فوریت های پزشکی',
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

                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: [
                                 BoxShadow(
                                     color: Colors.black26,
                                     spreadRadius: 1,
                                     blurRadius: 4
                                 )
                               ]
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                               
                                 Row(
                                   children: [
                                     SizedBox(width: 8,),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Consumer<ProviderEms>(
                                         builder: (context,newstate,child){
                                           status=newstate.status;
                                           return FlutterSwitch(
                                             value: status,
                                             activeColor: Color(0xff38b000),
                                             onToggle: (val) {
                                               ChangShift(val,context);


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
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: [
                                 BoxShadow(
                                     color: Colors.black26,
                                     spreadRadius: 1,
                                     blurRadius: 4
                                 )
                               ]
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Consumer<ProviderEms>(
                               builder: (ctx,newstate,child){
                                 return Column(
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: TextApp2('اطلاعات بیمار', 18, ColorTitleText, true),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(16.0),
                                       child: Directionality(
                                         textDirection: TextDirection.rtl,
                                         child: TextField(
                                           controller: TextConName,
                                           decoration: InputDecoration(
                                             labelText: 'نام و نام خانوادگی',
                                             disabledBorder:OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(8)
                                             ),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(8)
                                             ),

                                           ),
                                         ),
                                       ),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(16.0),
                                       child: Directionality(
                                         textDirection: TextDirection.rtl,
                                         child: TextField(
                                           controller: TextConCode,
                                           decoration: InputDecoration(
                                             labelText: 'کد ملی',

                                             disabledBorder:OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(8)
                                             ),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(8)
                                             ),

                                           ),
                                         ),
                                       ),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(16.0),
                                       child: Directionality(
                                         textDirection: TextDirection.rtl,
                                         child: TextField(
                                           controller: TextConAge,
                                           decoration: InputDecoration(
                                             labelText: 'سن',
                                             disabledBorder:OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(8)
                                             ),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(8)
                                             ),

                                           ),
                                         ),
                                       ),
                                     ),
                                     Padding(
                                         padding: const EdgeInsets.all(16.0),
                                         child: Directionality(
                                           textDirection: TextDirection.rtl,
                                           child: DropdownButtonFormField(
                                             value: Notifi.dropdownvalue,
                                             decoration: const InputDecoration(
                                               border: OutlineInputBorder(
                                                 borderRadius:   BorderRadius.all(
                                                   Radius.circular(8.0),
                                                 ),
                                               ),
                                             ),
                                             items: items.map((String items) {
                                               return DropdownMenuItem(
                                                 value: items,
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                   children: [
                                                     Text(
                                                       items,),
                                                   ],
                                                 ),
                                               );
                                             }).toList(),
                                             onChanged: (value) {
                                             Notifi.setdropdownvalue(value.toString());
                                           },
                                           ),
                                         )),

                                     Container(
                                       width: wid,
                                       margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                       child: ElevatedButton(onPressed: (){
                                         RunAddP(context);
                                       },
                                           style: ButtonStyle(
                                               backgroundColor: MaterialStateProperty.all(ColorApp),
                                               padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                   RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.circular(8.0),
                                                   )
                                               )
                                           ),
                                           child:Padding(
                                             padding: const EdgeInsets.all(10.0),
                                             child: Text('ثبت بیمار',
                                               style: TextStyle(color:Colors.white,
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.bold),),
                                           )),
                                     ),
                                     SizedBox(height: 8,)
                                   ],
                                 );
                               },

                             ),
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

