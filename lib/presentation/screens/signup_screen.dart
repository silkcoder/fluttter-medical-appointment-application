import 'package:doctor_appointment/bloc/signup/signup_bloc.dart';
import 'package:doctor_appointment/bloc/signup/signup_form_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.formStatus is SignupFormSuccess) {
               Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Sign Up to Masterminds',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return getTextField(
                        hintText: 'Full Name',
                        onChanged: (value) {
                          context.read<SignupBloc>().add(
                                NameChanged(name: value),
                              );
                        },
                        validator: (value) =>
                            state.name.isValid ? null : state.name.error,
                        autovalidateMode: AutovalidateMode.values[
                            state.formStatus is SignupFormSubmitted ? 1 : 0],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return getTextField(
                        hintText: 'Email',
                        onChanged: (value) {
                          context.read<SignupBloc>().add(
                                EmailChanged(email: value),
                              );
                        },
                        validator: (value) =>
                            state.email.isValid ? null : state.email.error,
                        autovalidateMode: AutovalidateMode.values[
                            state.formStatus is SignupFormSubmitted ? 1 : 0],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return getTextField(
                        hintText: 'Password',
                        onChanged: (value) {
                          context.read<SignupBloc>().add(
                                PasswordChanged(password: value),
                              );
                        },
                        validator: (value) => state.password.isValid
                            ? null
                            : state.password.error,
                        autovalidateMode: AutovalidateMode.values[
                            state.formStatus is SignupFormSubmitted ? 1 : 0],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return getTextField(
                        hintText: 'Confirm password',
                        onChanged: (value) {
                          context.read<SignupBloc>().add(
                                ConfirmPasswordChanged(confirmPassword: value),
                              );
                        },
                        validator: (value) => state.confirmPassword.isValid
                            ? null
                            : state.confirmPassword.error,
                        autovalidateMode: AutovalidateMode.values[
                            state.formStatus is SignupFormSubmitted ? 1 : 0],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.formStatus is SignupFormSubmitting
                              ? null
                              : () {
                                  context.read<SignupBloc>().add(
                                        SignupSubmitted(),
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
                          child: const Text('Create Account'),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  //show login failed message
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      if (state.formStatus is SignupFormFailure) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            (state.formStatus as SignupFormFailure)
                                .errorMessage,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.red),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
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
                      const Text('or Sign Up with'),
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
                        'By signing up, you agree to our ',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      Text(
                        'Terms of Service',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.purple),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getTextField(
    {required String hintText,
    Function(String)? onChanged,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode}) {
  return TextFormField(
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
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 0),
        borderRadius: BorderRadius.circular(8.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 0),
        borderRadius: BorderRadius.circular(8.r),
      ),
      filled: true,
      fillColor: Colors.grey[200],
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      hintStyle: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey),
    ),
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: autovalidateMode,
  );
}
