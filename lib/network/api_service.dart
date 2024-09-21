import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  // Private constructor
  ApiService._internal();
  // Singleton instance
  static final ApiService _instance = ApiService._internal();
  // Getter for the instance
  static ApiService get instance => _instance;
  late Dio _dio;
  // Configuration function
  void configureDio({
    required String baseUrl,
    Map<String, dynamic>? defaultHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    void Function(RequestOptions options, RequestInterceptorHandler handler)?
        onRequest,
    void Function(Response response, ResponseInterceptorHandler handler)?
        onResponse,
    void Function(DioError e, ErrorInterceptorHandler handler)? onError,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout?.inMilliseconds ??
          const Duration(seconds: 30).inMilliseconds,
      receiveTimeout: receiveTimeout?.inMilliseconds ??
          const Duration(seconds: 30).inMilliseconds,
      headers: defaultHeaders ??
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequest ??
            (options, handler) {
              debugPrint('Request: ${options.method} ${options.path}');
              debugPrint('Headers: ${options.headers}');
              debugPrint('Query Params: ${options.queryParameters}');
              handler.next(options);
            },
        onResponse: onResponse ??
            (response, handler) {
              debugPrint('Response: ${response.statusCode} ${response.data}');
              handler.next(response);
            },
        onError: onError ??
            (DioError e, handler) {
              debugPrint('X-Error: ${e.response?.statusCode} ${e.response!.data}');
              debugPrint('Error: ${e.message}');
              handler.next(e);
            },
      ),
    );
  }

  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequest(String endpoint,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
