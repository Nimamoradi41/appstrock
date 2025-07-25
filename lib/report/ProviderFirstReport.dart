import 'package:appstrock/report/model/ModelFirstReport.dart';
import 'package:appstrock/report/model/ModelFirstReportDate.dart';
import 'package:flutter/cupertino.dart';

class ProviderFirstReport extends ChangeNotifier{
   bool status=false;

   ModelFirstReport modelFirstReport=ModelFirstReport(data: ModelFirstReportDate(countPatient: 0, count724: 0, countInjection: 0, medicinePatient: [],
   ),errors: false,message: '',success: false);



   void setItems(ModelFirstReport modelFirstReportNew)
   {
     modelFirstReport=modelFirstReportNew;
     isLoading=false;
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