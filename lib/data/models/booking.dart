class Booking {

    List<Map<String, String>>slots;
    List<Map<String, String>> dates;

    Booking({
        required this.slots,
        required this.dates,
    });

    factory Booking.fromJson(Map<String, dynamic> json) {

        return Booking(
            slots: List<Map<String, String>>.from(json['slots'].map((x) => Map<String, String>.from(x))),
            dates: List<Map<String, String>>.from(json['dates'].map((x) => Map<String, String>.from(x))),
        );
    }

    Booking copyWith({
        List<Map<String, String>>? slots,
        List<Map<String, String>>? dates,
    }) {
        return Booking(
            slots: slots ?? this.slots,
            dates: dates ?? this.dates,
        );
    }

}