import 'package:doctor_appointment/bloc/login/login_bloc.dart';
import 'package:doctor_appointment/bloc/login/login_form_status.dart';
import 'package:doctor_appointment/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.formStatus is LoginFormSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
          }
        },
        child: SingleChildScrollView(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.formStatus is LoginFormSuccess) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const WelcomeScreen()));
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Image.asset(
                      'assets/images/doctor_selected.jpeg',
                      fit: BoxFit.cover,
                      //add opacity here
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 0),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Emails',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(EmailChanged(email: value));
                        },
                        validator: (value) =>
                            state.email.isValid ? null : state.email.error,
                        autovalidateMode: AutovalidateMode.values[
                            state.formStatus is LoginFormSubmitted ? 1 : 0],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 0),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 14.h),
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(PasswordChanged(password: value)),
                        validator: (value) => state.password.isValid
                            ? null
                            : state.password.error,
                        autovalidateMode: AutovalidateMode.values[
                            state.formStatus is LoginFormSubmitted ? 1 : 0],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  //add login button here
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.formStatus is LoginFormSubmitting
                              ? null
                              : () {
                                  context.read<LoginBloc>().add(
                                        LoginSubmitted(),
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 188, 89, 207),
                            foregroundColor: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w700),
                            padding: EdgeInsets.symmetric(
                                vertical: 14.h, horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            disabledBackgroundColor:
                                const Color.fromARGB(255, 197, 130, 211),
                            disabledForegroundColor: Colors.white,
                          ),
                          child: const Text('Login'),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  //show login failed message here
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state.formStatus is! LoginFormFailure) {
                        return Container();
                      }

                      return Text(
                        'Login Failed, Invalid email or password',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      const Text('or Login with'),
                      SizedBox(
                        width: 16.w,
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Colors.grey)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w700)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 14.h)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //load Image aseet from assets/Google.png
                          Image.asset('assets/images/Google.png'),
                          SizedBox(
                            width: 8.w,
                          ),
                          const Text('Google'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Wrap(
                    children: [
                      Text(
                        'New to Easy Doctor Appointment?',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text(
                          'Sign Up Now',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

Widget getTextField({required String hintText}) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(8.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.purple, width: 0),
        borderRadius: BorderRadius.circular(8.r),
      ),
      filled: true,
      fillColor: Colors.grey[200],
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      hintStyle: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey),
    ),
  );
}
