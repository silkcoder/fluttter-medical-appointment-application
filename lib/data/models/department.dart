class Department {
  final int id;
  final String name;
  final String logo;

  Department({required this.id, required this.name, required this.logo});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
