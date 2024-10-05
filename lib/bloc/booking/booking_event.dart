part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}


class BookingInitialEvent extends BookingEvent {
  Doctor doctor;
  BookingInitialEvent({required this.doctor});
}

class BookingDateSelectedEvent extends BookingEvent {
  int index;
  BookingDateSelectedEvent({required this.index});
}

class BookingSlotSelectedEvent extends BookingEvent {
  int index;
  BookingSlotSelectedEvent({required this.index});
}

//Booking Initiated and Booking Completed Events
class BookingInitiatedEvent extends BookingEvent {

  BookingInitiatedEvent();
}

class BookingCompletedEvent extends BookingEvent {

  BookingCompletedEvent();
}