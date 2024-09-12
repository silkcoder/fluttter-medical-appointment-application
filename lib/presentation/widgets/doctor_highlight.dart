import 'package:flutter/cupertino.dart';

class DoctorHighLight extends StatelessWidget {
  const DoctorHighLight({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Image(
          image: AssetImage('assets/images/experience.png'),
          width: 48,
          height: 48,
        ),
        SizedBox(height: 18),
        Text(
          '116+',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Patients ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF878787),
          ),
        ),
      ],
    );
  }
}
