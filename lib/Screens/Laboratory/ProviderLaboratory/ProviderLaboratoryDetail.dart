import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderLaboratoryDetail extends ChangeNotifier{


  late ModelPatient ListItemsPatient;
  bool status=false;
   void setItems(ModelPatient newitem)
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