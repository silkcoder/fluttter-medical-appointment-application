import 'package:doctor_appointment/data/models/doctor.dart';
import 'package:doctor_appointment/presentation/widgets/doctor_highlight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final Doctor doctor = arguments['doctor'] as Doctor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  expandedHeight: 320.0,
                  flexibleSpace: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(42.r),
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/doctor_selected.jpeg'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      margin: EdgeInsets.only(top: 20.h),
                      child: CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.favorite_outline),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ]),
              SliverFixedExtentList(
                itemExtent: 600.00,
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                                Text(
                                  doctor.designation,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF878787),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFD33C),
                                ),
                                SizedBox(width: 7.w),
                                Text(
                                  '${doctor.rating} (${doctor.reviews} reviews)',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 42.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DoctorHighLight(
                                value: doctor.patients, label: 'Patients'),
                            DoctorHighLight(
                                value: doctor.experience, label: 'Years'),
                            DoctorHighLight(
                                value: doctor.rating, label: 'Rating'),
                            DoctorHighLight(
                                value: doctor.reviews, label: 'Reviews'),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const Text(
                          'About Me',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          doctor.about,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF878787),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/booking',
                                    arguments: {'doctor': doctor});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: const Text('Book Appointment'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
