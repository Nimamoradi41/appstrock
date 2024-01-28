import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderResident extends ChangeNotifier{


  List<ModelPatient> ListItemsPatient=[];
  bool status=false;
   void setItems(List<ModelPatient> newitem)
   {
     ListItemsPatient=newitem;
     notifyListeners();
   }

  void setstatus(bool newst)
  {
    status=newst;
    notifyListeners();
  }

}