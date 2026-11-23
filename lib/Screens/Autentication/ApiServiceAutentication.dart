// Keep the public method names used by the existing screens.
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../core/api_exception.dart';
import 'Models/ModelLogin.dart';
import 'Models/ModelOtpCode.dart';
import 'Models/ModelRigester.dart';
import 'data/AuthenticationRepository.dart';

class ApiServiceAutentication {
  static final _repository = AuthenticationRepository();

  static Future<ModelRigester?> Rigester(
    String Name,
    String Typeuser,
    String NationalCode,
    String PhoneNumber,
    String Password,
    BuildContext context,
  ) {
    return _execute(
      context,
      () => _repository.register(
        name: Name,
        departmentId: Typeuser,
        nationalCode: NationalCode,
        mobileNumber: PhoneNumber,
        password: Password,
      ),
    );
  }

  static Future<ModelLogin?> Login(
    String Name,
    String NationalCode,
    String Pass,
    BuildContext context,
  ) {
    return _execute(
      context,
      () => _repository.login(
        name: Name,
        nationalCode: NationalCode,
        password: Pass,
      ),
    );
  }

  static Future<ModelOtpCode?> CheckConfirmCode(
    String Id,
    String Code,
    BuildContext context,
  ) {
    return _execute(
      context,
      () => _repository.checkConfirmCode(id: Id, code: Code),
    );
  }

  static Future<ModelOtpCode?> SendAgain(
    String Id,
    String mobileNumber,
    BuildContext context,
  ) {
    return _execute(
      context,
      () => _repository.sendAgain(id: Id, mobileNumber: mobileNumber),
    );
  }

  static Future<T?> _execute<T>(
    BuildContext context,
    Future<T> Function() request,
  ) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    DialogRoute<dynamic>? loadingRoute;
    // Inspect the top route without popping it. Splash login has no dialog.
    navigator.popUntil((route) {
      if (route is DialogRoute<dynamic> && !route.barrierDismissible) {
        loadingRoute = route;
      }
      return true;
    });

    try {
      return await request();
    } on ApiException catch (error) {
      if (context.mounted && !error.isCancelled) {
        ShowErrorMsg(context, error.toString());
      }
    } on FormatException {
      if (context.mounted) {
        ShowErrorMsg(context, 'ساختار پاسخ دریافتی از سرور نامعتبر است');
      }
    } catch (_) {
      if (context.mounted) {
        ShowErrorMsg(context, 'مشکلی در دریافت اطلاعات از سرور به وجود آمده');
      }
    } finally {
      final dialog = loadingRoute;
      if (navigator.mounted && dialog != null && dialog.isActive) {
        if (dialog.isCurrent) {
          navigator.pop();
        } else {
          navigator.removeRoute(dialog);
        }
      }
    }
    return null;
  }
}
