import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderStrok extends ChangeNotifier{

  List<ModelPatient> ListItemsPatient=[];
  late ModelPatient? PatientItem= ModelPatient(id: 14, fullName: 'Ahmad bagheri',
      nationalCode: '4845154444', age: '34', gender: 'Female',
      timeOfAddToSystem: '14:30', dateOfAddToSystem: '1402/01/01',
      needToMRI: false, isNot724: false,
      needToCT: false, nihsIsComplete: false,
      timeOfAddLabotory: '',
      ResonNot: '', is724IsComplete: true,
      AddReasonNot724: false,
      signsStartTime: '',
      fssTime: '', lkwTime: '',
      fssDate: '', lkwDate: '', signsStartIsUnknown: false,
      dateOfAddToStart: '', AtendSeen: false, Residents: '', Atends: '', Fesharkhon: '', Ghandkhon: '', signsStartDate: '', TimeOfInjection: '',
      labIsComplete: false, n_1_a: '',
      n_1_b: '', n_1_c: '', n_2: ''
      , n_3: '', n_4: '', n_5_a: ''
      , n_5_b: '', n_6_a: '',
      n_6_b: '', n_7: '',
      n_8: '', n_9: '', n_10: '', n_11: '',
      bun: '', cr: '', plt: '', pt: '',
      ptt: '', inr: '', trop: false);
  bool status=false;
  void setItem(ModelPatient newitem)
  {
    PatientItem=newitem;
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