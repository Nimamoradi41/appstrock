import 'package:dio/dio.dart';

import 'ErrorHandler.dart';

class ApiException extends DioException {
  ApiException({
    required RequestOptions requestOptions,
    required String message,
    Response<dynamic>? response,
    DioExceptionType type = DioExceptionType.unknown,
    dynamic error,
    StackTrace? stackTrace,
  }) : super(
          requestOptions: requestOptions,
          message: message,
          response: response,
          type: type,
          error: error,
          stackTrace: stackTrace,
        );

  factory ApiException.fromDioException(DioException exception) {
    return ApiException(
      requestOptions: exception.requestOptions,
      response: exception.response,
      type: exception.type,
      error: exception.error,
      stackTrace: exception.stackTrace,
      message: ErrorHandler.handleDioError(exception),
    );
  }

  int? get statusCode => response?.statusCode;

  bool get isUnauthorized => statusCode == 401;

  bool get isCancelled => type == DioExceptionType.cancel;

  @override
  String toString() => message!;
}
