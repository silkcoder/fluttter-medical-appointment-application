import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  late Dio _dio;
  static final DioService _singleton = DioService._internal();

  factory DioService() {    
    return _singleton;
  }

  DioService._internal() {
    initializeDio();
  }

  Future<String?> getToken() async {
    return 'token';
    //get token from shared preferences
  }

  Future<void> initializeDio() async {
    final token = await getToken();
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://ablepro.test/api',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          //pring request
          debugPrint(
              'Request: ${options.method} ${options.path} ${options.data}');
          debugPrint('Headers: ${options.headers}');
          debugPrint('Query Params: ${options.queryParameters}');

          return handler.next(options); // continue
        },

        onResponse: (response, handler) {
          // Do something with response data
          debugPrint('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // continue
        },

        onError: (DioError e, handler) {
          // Do something with response error
          debugPrint('X-Error: ${e.response?.statusCode} ${e.response!.data}');
          debugPrint('Error: ${e.message}');

          return handler.next(e); // continue
        },
        // ...
      ),
    );
  }

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return _dio.get(url, queryParameters: params);
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    return _dio.post(url, data: data);
  }

  // Add other methods like put, delete, etc. as needed
}
