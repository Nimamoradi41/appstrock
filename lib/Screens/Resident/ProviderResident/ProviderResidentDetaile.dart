import 'package:flutter/cupertino.dart';

import '../../Reception/Model/ModelPatient.dart';



class ProviderResidentDetaile extends ChangeNotifier{


  late ModelPatient? PatientItem= ModelPatient(id: 14, fullName: 'Ahmad bagheri',
      nationalCode: '4845154444', age: '34', gender: 'Female',
      timeOfAddToSystem: '14:30', dateOfAddToSystem: '1402/01/01',
      needToMRI: false, isNot724: false,
      needToCT: false, IsNIHSS: false,
      IsLab: false, timeOfAddLabotory: '',
      ResonNot: '', Is724: true,
      AddReasonNot724: false,
      timeOfAddResident: '',
      TimeFss: '', TimeLKW: '',
      DateFSS: '', DateLKW: '', IsUnknow: false,
      dateOfAddToStart: '', AtendSeen: false, Residents: '', Atends: '', Fesharkhon: '', Ghandkhon: '');
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