import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderAtendDetaile extends ChangeNotifier{


  late ModelPatient PatientItem;
  bool status=false;
  String oldTime="";
  String oldTime2="";
   void setItems(ModelPatient newitem)
   {
     PatientItem=newitem;
     notifyListeners();
   }

  void setstatus(bool newst)
  {
    status=newst;
    notifyListeners();
  }

  void setTimeEffect(String newTime)
  {
    oldTime=newTime;
    notifyListeners();
  }

  void setTimeAriveToHospital(String newTime)
  {
    oldTime2=newTime;
    notifyListeners();
  }

}