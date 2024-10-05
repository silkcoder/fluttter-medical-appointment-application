import 'package:bloc/bloc.dart';
import 'package:doctor_appointment/data/models/booking.dart';
import 'package:doctor_appointment/data/models/doctor.dart';
import 'package:doctor_appointment/data/repositories/booking_repository.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingRepository bookingRepository;
  late Doctor doctor;

  BookingBloc({required this.bookingRepository}) : super(BookingState()) {
    on<BookingInitialEvent>((event, emit) async {
      try {
        emit(BookingState());

        doctor = event.doctor;
        Booking booking =
            await bookingRepository.getBookingData(event.doctor, '');

        emit(BookingState(
            booking: booking,
            bookingDatesLoaded: true,
            bookingSlotsLoaded: true,
            bookingDatesLoading: false,
            bookingSlotsLoading: false));
      } catch (e) {
        print('Error: $e');
      }
    });

    on<BookingDateSelectedEvent>((event, emit) async {
      //emit(BookingState(bookingDatesLoading: true, bookingSlotsLoading: true));
      //delay 1 second

      emit(state.copyWith(
          bookingSlotsLoading: true,
          bookingSlotsLoaded: false,
          selectedDateIndex: event.index));

      String selectedDate =
          state.booking!.dates[event.index]['value'].toString();

      Booking booking =
          await bookingRepository.getBookingData(doctor, selectedDate);

      emit(state.copyWith(
          booking: booking,
          bookingDatesLoaded: true,
          bookingSlotsLoaded: true,
          bookingDatesLoading: false,
          bookingSlotsLoading: false,
          selectedDateIndex: event.index));

      //delay for 1 second
      // await Future.delayed(const Duration(seconds: 1));
      // BookingLoaded bookingLoaded = state as BookingLoaded;
      //emit(state.copyWith(selectedDateIndex: event.index));
    });

    on<BookingSlotSelectedEvent>((event, emit) async {
      emit(state.copyWith(selectedSlotIndiex: event.index));
    });

    on<BookingInitiatedEvent>((event, emit) async {
      String selectedDate =
          state.booking!.dates[state.selectedDateIndex]['value'].toString();
      String selectedSlot =
          state.booking!.slots[state.selectedSlotIndiex]['value'].toString();

      await bookingRepository.bookSlot(doctor, selectedDate, selectedSlot);

      emit(state.copyWith(bookingCompleted: true));
    });
  }
}
