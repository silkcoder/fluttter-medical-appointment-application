import 'package:dio/dio.dart';
import 'package:doctor_appointment/data/models/user.dart';
import 'package:doctor_appointment/network/api_service.dart';

class SignUpDataProvider {
  Future<User> signUp(String name, String email, String password) async {
    try {
      ApiService apiService = ApiService.instance;
      apiService.configureDio(baseUrl: 'http://ablepro.test/api');

      Response postResponse = await apiService.postRequest(
        '/register',
        data: {
          'name': name,
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
