import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_slot/time_slot_from_interval.dart';
import 'package:time_slot/time_slot_from_list.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 390.h,
        flexibleSpace: Stack(children: [
          Container(
            //add image here
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/doctor_selected.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              child: Container(
                //add border radius here on top left and top right
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.r),
                    topRight: Radius.circular(45.r),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 65,
              ),
            ),
          ),
          //place a position widget here, blue container box
          Positioned(
            bottom: 22,
            left: 0,
            child: Container(
              margin: EdgeInsets.only(left: 45.w, right: 45.w),
              width: 308.w,
              height: 113,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.r),
                color: const Color(0xff3e69fe),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 8),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Text(
                      'Dr. Ali Uzair',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      'Senior Cardiologist and Surgeon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      'Mirpur Medical College and Hospital',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //change color of selected date
                print(selectedDate);
              },
            ),
            TimesSlotGridViewFromList(
              locale: "en",
              initTime: selectTime,
              crossAxisCount: 4,
              listDates: [
                DateTime(2023, 1, 1, 10, 30),
                DateTime(2023, 1, 1, 11, 30),
                DateTime(2023, 1, 1, 12, 30),
                DateTime(2023, 1, 1, 13, 30),
                DateTime(2023, 1, 1, 14, 30),
                DateTime(2023, 1, 1, 15, 30),
                DateTime(2023, 1, 1, 21, 30)
              ],
              onChange: (value) {
                setState(() {
                  selectTime = value;
                });
              },
            ),
          ],
        ),
      ),
    ));
  }
}
