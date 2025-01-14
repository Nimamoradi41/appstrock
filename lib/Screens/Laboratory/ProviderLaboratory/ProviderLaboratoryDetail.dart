import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderLaboratoryDetail extends ChangeNotifier{


  late ModelPatient patientItem;
  bool status=false;
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

}