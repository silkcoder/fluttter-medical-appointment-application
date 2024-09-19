import 'package:dio/dio.dart';
import 'package:doctor_appointment/data/models/user.dart';
import 'dart:convert';

class SignUpDataProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://ablepro.test/api/',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ));

  Future<User> signUp(String name, String email, String password) async {
    try {
      final Response response = await _dio.post('register', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
              
        return User.fromJson(response.data);
      } else {
        return Future.error('Sign up failed');
      }
    } catch (e) {

      print('INSIDE DATA PROVIDER CATCH 123');
      return Future.error(e);
    }

    return Future.error('Sign up failed');
  }
}
