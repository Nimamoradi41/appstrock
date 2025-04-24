import 'dart:async';
import 'package:flutter/material.dart';

class ProviderTimers extends ChangeNotifier {



  void updateTimerArriveToHospital(String timer){
    timerArriveToHospital=timer;
    notifyListeners();
  }

  void updateTimerSymptomOnset(String timer){
    timerTimerSymptomOnset=timer;
    notifyListeners();
  }

  void updateTimerSymptomRecognition(String timer){
    timerSymptomRecognition=timer;
    notifyListeners();
  }


  String   timerArriveToHospital  ='';
  String   timerTimerSymptomOnset  ='';
  String   timerSymptomRecognition  ='';

}
