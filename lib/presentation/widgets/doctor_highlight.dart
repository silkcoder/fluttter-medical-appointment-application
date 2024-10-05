import 'package:doctor_appointment/data/models/doctor.dart';
import 'package:flutter/cupertino.dart';

class DoctorHighLight extends StatelessWidget {
  late String value;
  late String label;
  
  DoctorHighLight({super.key, required this.value, required this.label});

  Map images = {
    'Rating': 'assets/images/rating.png',
    'Years': 'assets/images/experience.png',
    'Patients': 'assets/images/patients.png',
    'Reviews': 'assets/images/reviews.png',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(images[label]),
          width: 48,
          height: 48,
        ),
        const SizedBox(height: 18),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF878787),
          ),
        ),
      ],
    );
  }
}
