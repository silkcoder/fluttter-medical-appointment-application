import 'package:doctor_appointment/data/data_providers/login_data_provider.dart';
import 'package:doctor_appointment/data/models/user.dart';

class AuthRepository {
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    LoginDataProvider loginDataProvider = LoginDataProvider();

    return await loginDataProvider.login(email, password);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    // Sign up with email and password
  }
}
