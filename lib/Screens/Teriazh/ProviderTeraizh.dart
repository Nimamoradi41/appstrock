import 'package:flutter/cupertino.dart';

import '../Reception/Model/ModelPatient.dart';





class ProviderTeraizh extends ChangeNotifier{

  String dropdownvalue = 'مرد';

  List<ModelPatient> ListItemsPatient=[];
  bool status=false;
   void setItems(List<ModelPatient> newitem)
   {
     ListItemsPatient=newitem;
     notifyListeners();
   }
  void setdropdownvalue(String dropdownvaluenew)
  {
    dropdownvalue=dropdownvaluenew;
    notifyListeners();
  }

  void setstatus(bool newst)
  {
    status=newst;
    notifyListeners();
  }

  void Refrsh()
  {
    notifyListeners();
  }

}