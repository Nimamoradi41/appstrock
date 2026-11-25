import 'package:dio/dio.dart';

import 'AppConfig.dart';
import 'api_exception.dart';

class ApiClient {
  static final instance = ApiClient();

  final Dio dio;

  ApiClient({
    HttpClientAdapter? adapter,
    String baseUrl = AppConfig.baseUrl,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: AppConfig.connectTimeout,
            sendTimeout: AppConfig.sendTimeout,
            receiveTimeout: AppConfig.receiveTimeout,
            contentType: Headers.jsonContentType,
            headers: {'Accept': Headers.jsonContentType},
            followRedirects: false,
          ),
        ) {
    if (adapter != null) dio.httpClientAdapter = adapter;
    dio.interceptors.add(_ApiErrorInterceptor());
  }
}

class _ApiErrorInterceptor extends Interceptor {
  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    handler.next(
      error is ApiException ? error : ApiException.fromDioException(error),
    );
  }
}
