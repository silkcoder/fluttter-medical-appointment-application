class Doctor {
  final int id;
  final String name;
  final String designation;
  final String timing;
  final String fees;
  final String patients;
  final String rating;
  final String reviews;
  final String experience;
  final String about;
  final String photo;

  Doctor({
    required this.id,
    required this.name,    
    required this.designation,
    required this.timing,
    required this.fees,
    required this.patients,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.about,
    required this.photo,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      designation: json['designation'],
      timing: json['timing'],
      fees: json['fees'],
      patients: json['patients'],
      rating: json['rating'],
      reviews: json['reviews'],
      experience: json['experience'],
      about: json['about'],
      photo: json['photo'],
    );
  }
}