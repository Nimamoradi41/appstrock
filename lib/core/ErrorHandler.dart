import 'dart:convert';

import 'package:dio/dio.dart';

class ErrorHandler {
  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'زمان اتصال به سرور به پایان رسید';
      case DioExceptionType.sendTimeout:
        return 'زمان ارسال اطلاعات به سرور به پایان رسید';
      case DioExceptionType.receiveTimeout:
        return 'زمان دریافت اطلاعات از سرور به پایان رسید';
      case DioExceptionType.connectionError:
        return 'مشکلی در ارتباط با سرور به وجود آمده';
      case DioExceptionType.badCertificate:
        return 'گواهی امنیتی سرور معتبر نیست';
      case DioExceptionType.cancel:
        return 'درخواست لغو شد';
      case DioExceptionType.badResponse:
        final message = extractServerMessage(error.response?.data);
        if (message != null) return message;

        final statusCode = error.response?.statusCode;
        if (statusCode == 400) return 'درخواست نامعتبر است';
        if (statusCode == 401) return 'نشست شما معتبر نیست؛ دوباره وارد شوید';
        if (statusCode == 403) return 'اجازه دسترسی به این بخش را ندارید';
        if (statusCode == 404) return 'اطلاعات موردنظر پیدا نشد';
        if (statusCode == 422) return 'اطلاعات ارسال‌شده معتبر نیست';
        if (statusCode == 429) return 'تعداد درخواست‌ها زیاد است؛ کمی صبر کنید';
        if (statusCode != null && statusCode >= 500) {
          return 'خطای داخلی سرور';
        }
        return 'خطا در ارتباط با سرور';
      case DioExceptionType.unknown:
        return 'خطای ناشناخته در ارتباط با سرور رخ داده است';
    }
  }

  static String? extractServerMessage(dynamic data) {
    if (data is String) {
      try {
        data = jsonDecode(data);
      } on FormatException {
        return null;
      }
    }
    if (data is! Map) return null;

    for (final key in ['message', 'msg', 'detail', 'errors']) {
      final message = _message(data[key]);
      if (message != null) return message;
    }
    return null;
  }

  static String? _message(dynamic value) {
    if (value is String && value.trim().isNotEmpty) return value.trim();
    if (value is List) {
      final messages = value.map(_message).whereType<String>().toList();
      return messages.isEmpty ? null : messages.join('\n');
    }
    if (value is Map) {
      final messages = <String>[];
      for (final entry in value.entries) {
        final message = _message(entry.value);
        if (message != null) messages.add('${entry.key}: $message');
      }
      return messages.isEmpty ? null : messages.join('\n');
    }
    return null;
  }
}
