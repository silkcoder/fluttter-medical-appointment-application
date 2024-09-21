import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor_appointment/data/data_providers/login_data_provider.dart';
import 'package:doctor_appointment/data/data_providers/signup_data_provider.dart';
import 'package:doctor_appointment/data/models/user.dart';

class AuthRepository {
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    LoginDataProvider loginDataProvider = LoginDataProvider();

    return await loginDataProvider.login(email, password);
  }

  Future<User> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    SignUpDataProvider signUpDataProvider = SignUpDataProvider();

    try {
      User user = await signUpDataProvider.signUp(name, email, password);
      return user;
    } catch (e) {
      return Future.error(e);
    }
  }
}
