import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderEms extends ChangeNotifier{



  bool status=false;


  void setstatus(bool newst)
  {
    status=newst;
    notifyListeners();
  }

}