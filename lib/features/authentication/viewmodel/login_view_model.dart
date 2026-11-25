import 'package:flutter/foundation.dart';

import '../../../core/api_exception.dart';

import '../data/AuthenticationRepository.dart';
import '../data/login_session_storage.dart';
import '../model/ModelLogin.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    AuthenticationRepository? repository,
    LoginSessionStorage? sessionStorage,
  })  : _repository = repository ?? AuthenticationRepository(),
        _sessionStorage = sessionStorage ?? LoginSessionStorage();

  final AuthenticationRepository _repository;
  final LoginSessionStorage _sessionStorage;

  bool _isLoading = false;
  bool _disposed = false;
  bool _isValidationError = false;
  String? _errorMessage;
  Data? _user;

  bool get isLoading => _isLoading;
  bool get isValidationError => _isValidationError;
  String? get errorMessage => _errorMessage;
  Data? get user => _user;

  Future<bool> login({
    required String name,
    required String nationalCode,
    required String password,
  }) async {
    if (_isLoading || _disposed) return false;

    _errorMessage = null;
    _isValidationError = false;
    _user = null;

    if (name.isEmpty) {
      return _validationFailure('نام و نام خانوادگی را وارد کنید');
    }
    if (nationalCode.isEmpty) {
      return _validationFailure('کدملی را وارد کنید');
    }
    if (nationalCode.length != 10) {
      return _validationFailure('کدملی اشتباه است');
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.login(
        name: name,
        nationalCode: nationalCode,
        password: password,
      );
      if (_disposed) return false;
      if (!response.success) {
        _errorMessage = response.message;
        return false;
      }

      final user = response.data;
      if (user == null) {
        _errorMessage = 'ساختار پاسخ دریافتی از سرور نامعتبر است';
        return false;
      }

      await _sessionStorage.save(
        name: name,
        nationalCode: nationalCode,
        password: password,
        user: user,
      );
      if (_disposed) return false;
      _user = user;
      return true;
    } on ApiException catch (error) {
      if (!error.isCancelled) _errorMessage = error.toString();
    } on FormatException {
      _errorMessage = 'ساختار پاسخ دریافتی از سرور نامعتبر است';
    } catch (_) {
      _errorMessage = 'مشکلی در دریافت اطلاعات از سرور به وجود آمده';
    } finally {
      if (!_disposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
    return false;
  }

  bool _validationFailure(String message) {
    _isValidationError = true;
    _errorMessage = message;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
