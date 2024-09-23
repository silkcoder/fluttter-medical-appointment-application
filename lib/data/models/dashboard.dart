
import 'package:doctor_appointment/data/models/department.dart';
import 'package:doctor_appointment/data/models/doctor.dart';

class Dashboard {

  List<Department> departments = [];
  List<Doctor> doctors = [];

  Dashboard({required this.departments, required this.doctors});
}