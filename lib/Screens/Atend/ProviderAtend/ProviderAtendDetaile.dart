import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderAtendDetaile extends ChangeNotifier{


  late ModelPatient patientItem;
  bool status=false;
  String oldTime="";
  String oldTime2="";
  // String oldTime3="";
   void setItems(ModelPatient newitem)
   {
     patientItem=newitem;
     notifyListeners();
   }
  bool isLoading=true;
  void setLoading(bool newLoading)
  {
    isLoading=newLoading;
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

  // void setTimeInje(String newTime)
  // {
  //   oldTime3=newTime;
  //   notifyListeners();
  // }



}