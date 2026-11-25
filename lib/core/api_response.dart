import 'dart:convert';

class ApiResponse {
  // Keep the whole envelope: existing auth models read success/message/errors.
  static Map<String, dynamic> object(dynamic data) {
    if (data is String) {
      try {
        data = jsonDecode(data);
      } on FormatException {
        throw const FormatException('ساختار پاسخ دریافتی از سرور نامعتبر است');
      }
    }
    if (data is Map<String, dynamic>) return data;
    throw const FormatException('ساختار پاسخ دریافتی از سرور نامعتبر است');
  }
}
