import 'package:bloc/bloc.dart';
import 'package:doctor_appointment/data/models/dashboard.dart';
import 'package:doctor_appointment/data/models/department.dart';
import 'package:doctor_appointment/data/models/doctor.dart';
import 'package:doctor_appointment/data/repositories/dashboard_depository.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardRepository dashboardRepository;

  DashboardBloc({required this.dashboardRepository})
      : super(DashboardInitial()) {
    on<DashboardInitialEvent>((event, emit) async {
      emit(DashboardLoading());
      Dashboard dashboard = await dashboardRepository.getDashboard();
      List<Department> departments = dashboard.departments;
      List<Doctor> doctors = dashboard.doctors;
      emit(DashboardLoaded(departments: departments, doctors: doctors));
    });
  }
}
