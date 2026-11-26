import 'package:flutter/foundation.dart';

import '../../../core/api_exception.dart';
import '../data/patient_repository.dart';
import '../model/patient_registration.dart';

class PatientRegistrationViewModel extends ChangeNotifier {
  PatientRegistrationViewModel({PatientRepository? repository})
      : _repository = repository ?? PatientRepository();

  final PatientRepository _repository;
  bool isLoading = false;
  bool _disposed = false;
  String? errorMessage;

  Future<bool> register(PatientRegistration patient) async {
    if (isLoading || _disposed) return false;
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final response = await _repository.register(patient);
      if (!response.success) errorMessage = response.message;
      return response.success;
    } on ApiException catch (error) {
      print(error.toString());
      if (!error.isCancelled) errorMessage = error.toString();
    } on FormatException {
      errorMessage = 'ساختار پاسخ دریافتی از سرور نامعتبر است';
    } catch (_) {
      errorMessage = 'مشکلی در ارتباط با سرور به وجود آمده است';
    } finally {
      isLoading = false;
      if (!_disposed) notifyListeners();
    }
    return false;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
