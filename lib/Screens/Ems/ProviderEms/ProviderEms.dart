import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderEms extends ChangeNotifier{


  String dropdownvalue = 'مرد';
  bool status=false;


  void setstatus(bool newst)
  {
    status=newst;
    notifyListeners();
  }

  void setdropdownvalue(String dropdownvaluenew)
  {
    dropdownvalue=dropdownvaluenew;
    notifyListeners();
  }

  void Refrsh()
  {
    notifyListeners();
  }

}