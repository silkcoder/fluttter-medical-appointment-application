import 'package:doctor_appointment/data/models/user.dart';

class LoginDataProvider {
  Future<User> login(String email, String password) async {
    // Simulate a network request
    try {
      await Future.delayed(const Duration(seconds: 3));
      if (email == 'hello@test.com' && password == 'password') {
        User user = User(
          token: 'token',
          email: 'hello@est.com',
          name: 'John Doe',
        );

        return user;
      }

      return Future.error('Invalid email or password');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
