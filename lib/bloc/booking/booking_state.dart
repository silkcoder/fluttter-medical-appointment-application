part of 'booking_bloc.dart';

class BookingState {

  Booking? booking;
  bool bookingDatesLoading;
  bool bookingDatesLoaded;
  bool bookingSlotsLoading;
  bool bookingSlotsLoaded;
  bool bookingCompleted;
  int selectedDateIndex = 0;
  int selectedSlotIndiex = 0;

  BookingState({
    this.booking,
    this.bookingDatesLoading = false,
    this.bookingDatesLoaded = false,
    this.bookingSlotsLoading = true,
    this.bookingSlotsLoaded = true,
    this.bookingCompleted = false,
    this.selectedSlotIndiex = 0,
    this.selectedDateIndex = 0,
  });

  BookingState copyWith({
    Booking? booking,
    bool? bookingDatesLoading,
    bool? bookingDatesLoaded,
    bool? bookingSlotsLoading,
    bool? bookingSlotsLoaded,
    bool? bookingCompleted,
    int? selectedSlotIndiex,
    int? selectedDateIndex,
  }) {
    return BookingState(
      booking: booking ?? this.booking,
      bookingDatesLoading: bookingDatesLoading ?? this.bookingDatesLoading,
      bookingDatesLoaded: bookingDatesLoaded ?? this.bookingDatesLoaded,
      bookingSlotsLoading: bookingSlotsLoading ?? this.bookingSlotsLoading,
      bookingSlotsLoaded: bookingSlotsLoaded ?? this.bookingSlotsLoaded,
      bookingCompleted: bookingCompleted ?? this.bookingCompleted,
      selectedSlotIndiex: selectedSlotIndiex ?? this.selectedSlotIndiex,
      selectedDateIndex: selectedDateIndex ?? this.selectedDateIndex,          
    );
  }
}