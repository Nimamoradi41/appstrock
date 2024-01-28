import 'package:flutter/cupertino.dart';

import '../Model/ModelPatient.dart';

class ProviderReception extends ChangeNotifier{


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