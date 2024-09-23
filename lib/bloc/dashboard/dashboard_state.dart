part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

final class DashboardInitial extends DashboardState {
  DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  DashboardLoading();
}

final class DashboardLoaded extends DashboardState {
  final List<Department> departments;
  final List<Doctor> doctors;

  DashboardLoaded({required this.departments, required this.doctors});

  DashboardLoaded copyWith({
    List<Department>? departments,
    List<Doctor>? doctors,
  }) {
    return DashboardLoaded(
      departments: departments ?? this.departments,
      doctors: doctors ?? this.doctors,
    );
  }
}


