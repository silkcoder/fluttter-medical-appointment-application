import 'package:doctor_appointment/data/models/doctor.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_slot/time_slot_from_interval.dart';
import 'package:time_slot/time_slot_from_list.dart';

import '../../bloc/booking/booking_bloc.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  //get Doctor from arguments
  Doctor getDoctor(Map arguments) {
    return arguments['doctor'] as Doctor;
  }

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectTime = DateTime.now();

  List list1 = [
    DateTime(2023, 1, 1, 10, 30),
    DateTime(2023, 1, 1, 11, 30),
    DateTime(2023, 1, 1, 12, 30),
    DateTime(2023, 1, 1, 13, 30),
    DateTime(2023, 1, 1, 14, 30),
    DateTime(2023, 1, 1, 15, 30),
    DateTime(2023, 1, 1, 21, 30)
  ];

  @override
  Widget build(BuildContext context) {
    //get Doctor from arguments
    Doctor doctor =
        widget.getDoctor(ModalRoute.of(context)?.settings.arguments as Map);
    //call bloc to get booking data
    context.read<BookingBloc>().add(BookingInitialEvent(doctor: doctor));

    return Scaffold(
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state.bookingCompleted) {
            Navigator.pushNamed(context, '/booking-completed');
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300.h,
                  child: Stack(
                    children: [
                      Container(
                        //add image here
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/doctor_selected.jpeg'),
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
                    ],
                  ),
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    if (state.bookingDatesLoading) {
                      return const CircularProgressIndicator();
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Choose appointment date',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              //add a horizontal list of datees here
                              Container(
                                margin: EdgeInsets.only(left: 0.w, right: 0.w),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                ),
                                height: 80.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.bookingDatesLoaded
                                      ? state.booking?.dates.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        context.read<BookingBloc>().add(
                                            BookingDateSelectedEvent(
                                                index: index));
                                      },
                                      child: Container(
                                        width: 70.w,
                                        padding: EdgeInsets.only(
                                            left: 15.w, right: 15.w, top: 12.h),
                                        margin: EdgeInsets.only(
                                            left: 0.w, right: 10.w),
                                        decoration: BoxDecoration(
                                          color:
                                              state.selectedDateIndex == index
                                                  ? Colors.blue[200]!
                                                  : Colors.blue[50]!,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color:
                                                state.selectedDateIndex == index
                                                    ? Colors.blue[300]!
                                                    : Colors.blue[100]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //style Day here
                                            Text(
                                              state.bookingDatesLoaded
                                                  ? state.booking!
                                                      .dates[index]['day']
                                                      .toString()
                                                  : '',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w900,
                                                color:
                                                    state.selectedDateIndex ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.grey[600],
                                              ),
                                            ),
                                            //style date here
                                            Text(
                                              state.bookingDatesLoaded
                                                  ? state.booking!
                                                      .dates[index]['date']
                                                      .toString()
                                                  : '',
                                              style: TextStyle(
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    state.selectedDateIndex ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Choose preferred time',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<BookingBloc, BookingState>(
                            builder: (context, state) {
                              if (state.bookingSlotsLoading) {
                                return const CircularProgressIndicator();
                              }

                              return Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    ...List.generate(
                                        state.bookingSlotsLoaded
                                            ? state.booking!.slots.length
                                            : 0, (index) {
                                      //return container as button
                                      return Container(
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color:
                                              state.selectedSlotIndiex == index
                                                  ? Colors.blue[200]!
                                                  : Colors.blue[50]!,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: state.selectedSlotIndiex ==
                                                    index
                                                ? Colors.blue[200]!
                                                : Colors.blue[50]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            context.read<BookingBloc>().add(
                                                BookingSlotSelectedEvent(
                                                    index: index));
                                          },
                                          child: Text(
                                            state.bookingSlotsLoaded
                                                ? state.booking!
                                                    .slots[index]['label']
                                                    .toString()
                                                : '',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                              color: state.selectedSlotIndiex ==
                                                      index
                                                  ? Colors.white
                                                  : Colors.grey[600]!,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const Text(
                            "Proceed to Book now once you choose date and time"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<BookingBloc>()
                                    .add(BookingInitiatedEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: const Text('Book now'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/welcome');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[200],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
