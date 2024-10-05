import 'package:doctor_appointment/data/data_providers/booking_data_provider.dart';
import 'package:doctor_appointment/data/models/doctor.dart';

class BookingRepository {
  BookingDataProvider bookingDataProvider;

  BookingRepository({required this.bookingDataProvider});

  Future getBookingData(Doctor doctor, [String? selectedDate]) async {
    return await bookingDataProvider.getBookingData(doctor, selectedDate);
  }

  //Book slot
  Future bookSlot(Doctor doctor, String selectedDate, String selectedSlot) async {
    return await bookingDataProvider.bookSlot(doctor, selectedDate, selectedSlot);
  }

}
