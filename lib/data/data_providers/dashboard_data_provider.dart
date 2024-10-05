import 'package:dio/dio.dart';
import 'package:doctor_appointment/data/models/dashboard.dart';
import 'package:doctor_appointment/data/models/department.dart';
import 'package:doctor_appointment/data/models/doctor.dart';
import 'package:doctor_appointment/network/api_service.dart';
import 'dart:convert';

class DashboardDataProvider {
  Future<Dashboard> getDashboardData(page) async {
    try {
      ApiService apiService = ApiService.instance;
      apiService.configureDio(baseUrl: 'http://ablepro.test/api');

      Response response = await apiService.getRequest('/dashboard?page=$page');
      Map<String, dynamic> data = jsonDecode(response.toString());

      List departmentsList = data['data']['departments'] ?? [];
      List<Department> departments = departmentsList
          .map((department) => Department.fromJson(department))
          .toList();

      List doctorsList = data['data']['doctors'] ?? [];
      
     List<Doctor> doctors = doctorsList.map((doctor) => Doctor.fromJson(doctor)).toList();

     Dashboard dashboard = Dashboard(departments: departments, doctors: doctors); 
      
      return dashboard;

    } catch (e) {
      return Future.error(e);
    }
  }
}
