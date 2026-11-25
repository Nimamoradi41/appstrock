import 'package:flutter/material.dart';

import '../../../Constants.dart';
import '../../../Screens/Atend/ScreenAtend.dart';
import '../../patient_registration/ui/screen_ems.dart';
import '../../../Screens/Laboratory/screen_Laboratory.dart';
import '../../../Screens/Reception/screen_reception.dart';
import '../../../Screens/Resident/resident_patients_preview.dart';
import '../../../Screens/Strok/ScreenStrock.dart';
import '../../../Screens/Teriazh/screen_teriazh.dart';
import '../../../Screens/sickcarrier/screen_sickcarrier.dart';

void openLoginHome(BuildContext context, int departmentId) {
  switch (departmentId) {
    case 1:
      GoNextPage(context, ScreenEms(false));
      break;
    case 2:
      GoNextPage(context, Screen_Teriazh());
      break;
    case 3:
      GoNextPage(context, ScreenReception());
      break;
    case 4:
      GoNextPage(context, ScreenSickCarrier());
      break;
    case 5:
      GoNextPageGameOver(context, ScreenAtend());
      break;
    case 6:
      GoNextPageGameOver(context, ScreenLaboratory());
      break;
    case 7:
      GoNextPage(context, const ResidentPatientsPreview());
      break;
    case 8:
      GoNextPageGameOver(context, ScreenStrock());
      break;
  }
}
