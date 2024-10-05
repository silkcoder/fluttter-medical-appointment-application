import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor_appointment/data/models/booking.dart';
import 'package:doctor_appointment/data/models/doctor.dart';

import '../../network/api_service.dart';

class BookingDataProvider {
  Future<Booking> getBookingData(Doctor doctor, [String? selectedDate]) async {
    try {
      ApiService apiService = ApiService.instance;
      apiService.configureDio(baseUrl: 'http://ablepro.test/api');

      Response response =
          await apiService.getRequest('/doctor/${doctor.id}/slots?date=$selectedDate');

      Map<String, dynamic> data = jsonDecode(response.toString());
      return Booking.fromJson(data['data']);
    } catch (e) {
      return Future.error(e);
    }
  }

  //bookSlot
  Future bookSlot(
      Doctor doctor, String selectedDate, String selectedSlot) async {
    try {
      ApiService apiService = ApiService.instance;
      apiService.configureDio(baseUrl: 'http://ablepro.test/api');

      Response response =
          await apiService.postRequest('/appointments/25', data: {
        'doctor': doctor.id,
        'date': selectedDate,
        'slot': selectedSlot,
      });

      Map<String, dynamic> data = jsonDecode(response.toString());
      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
