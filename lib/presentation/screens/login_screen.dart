
import 'package:doctor_appointment/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
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
                getTextField(hintText: 'Email'),
                SizedBox(
                  height: 16.h,
                ),
                getTextField(hintText: 'Password'),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      //on click go to WelcomeScreen
                      // print('action');
                      // Navigator.of(context).push(MaterialPageRoute(builder:   (context) => const WelcomeScreen()));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 210, 136, 223)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)))),
                    child: const Text('Login'),
                  ),
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
                    Text(
                      'Sign Up Now',
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
      )),
    );
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