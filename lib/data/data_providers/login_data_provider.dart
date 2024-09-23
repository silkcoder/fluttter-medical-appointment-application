import 'package:dio/dio.dart';
import 'package:doctor_appointment/data/models/user.dart';
import 'package:doctor_appointment/network/api_service.dart';

class LoginDataProvider {
  Future<User> login(String email, String password) async {
    // Simulate a network request
    try {
      ApiService apiService = ApiService.instance;
      apiService.configureDio(baseUrl: 'http://ablepro.test/api');

      Response postResponse = await apiService.postRequest(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return User.fromJson(postResponse.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}
