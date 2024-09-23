import 'package:doctor_appointment/bloc/login/login_bloc.dart';
import 'package:doctor_appointment/bloc/signup/signup_bloc.dart';
import 'package:doctor_appointment/data/repositories/auth_repository.dart';
import 'package:doctor_appointment/presentation/screens/login_screen.dart';
import 'package:doctor_appointment/presentation/screens/signup_screen.dart';
import 'package:doctor_appointment/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();
  final MainApp myApp = MainApp(
    initialRoute: isLogged ? '/welcome' : '/login',
  );

  runApp(myApp);
}

class MainApp extends StatelessWidget {
   final String initialRoute;
  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (BuildContext context, child) {
          return MaterialApp(
            routes: {
              '/login': (context) => RepositoryProvider(
                    create: (context) => AuthRepository(),
                    child: BlocProvider(
                      create: (context) => LoginBloc(
                        authRepository: context.read<AuthRepository>(),
                      ),
                      child: const LoginScreen(),
                    ),
                  ),
              '/signup': (context) => RepositoryProvider(
                    create: (context) => AuthRepository(),
                    child: BlocProvider(
                      create: (context) => SignupBloc(
                        authRepository: context.read<AuthRepository>(),
                      ),
                      child: const SignUp(),
                    ),
                  ),
              '/welcome': (context) => const WelcomeScreen(),
            },
            //set default route
            initialRoute: initialRoute,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

class Auth {
 
  Future<bool> isLogged() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    if(token != null) {
        return true;        
    }

    return false;
  }
}
