import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderStrok extends ChangeNotifier{

  List<ModelPatient> ListItemsPatient=[];
  var patientItem= ModelPatient(id: 14, fullName: 'Ahmad bagheri',
    nationalCode: '4845154444', age: '34', gender: 'Female',
    timeOfAddToSystem: '14:30', dateOfAddToSystem: '1402/01/01',
    needToMRI: false, isNot724: false,
    needToCT: false, nihsIsComplete: false,
    timeOfAddLabotory: '',
    ResonNot: '', is724IsComplete: true,
    isNot724IsComplete: false,
    signsStartTime: '',
    fssTime: '', lkwTime: '',
    fssDate: '', lkwDate: '', signsStartIsUnknown: false,
    dateOfAddToStart: '', seenByAttend: false, Residents: '', Atends: '', Fesharkhon: '', Ghandkhon: '', signsStartDate: '', timeOfInjection: '',
    labIsComplete: false, n_1_a: '',
    n_1_b: '', n_1_c: '', n_2: ''
    , n_3: '', n_4: '', n_5_a: ''
    , n_5_b: '', n_6_a: '',
    n_6_b: '', n_7: '',
    n_8: '', n_9: '', n_10: '', n_11: '',
    bun: '', cr: '', plt: '', pt: '',
    ptt: '', inr: '', trop: false, bloodPressure1: 0, bloodPressure2: 0, bs: 0, signsStartTS: 0, insertTimeTS: 0, injectionType: 0, misdiagnosisOfTriage: false, misdiagnosisOfEms: false, overTime: false, labInsertDate: '', labInsertTime: '', isFinished: false,
    notInjectingIsComplete: false, c1: false, c2: false, c3: false, c4: false,c5: false,c6: false,c8: false,c7: false,c9: false,c10: false,c11: false, c12: false, c13: false, c14: false, c15: false, c16: false, c17: false, c18: false, c19: false, c20: false, c21: false, c22: false, nihsSubscore: 0, injectionTimeTS: 0, wbc: '', hb: '', otn: '', dtn: '', timeFinish: '', dateFinishShamsi: '',);
  bool status=false;
  void setItem(ModelPatient newitem)
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