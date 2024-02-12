import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderResidentDetaile extends ChangeNotifier{


  late ModelPatient PatientItem;
  bool status=false;
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

}