import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorWidget extends StatelessWidget {
  const DoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: const Row(
        children: [
          Column(
            children: [
              Text('Dr. John Doe'),
              Text('Cardiologist'),
              Text('5 years experience'),
            ],
          )
        ],
      ),
    );
  }
}
