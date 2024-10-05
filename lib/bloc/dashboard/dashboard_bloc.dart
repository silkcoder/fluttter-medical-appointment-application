import 'package:bloc/bloc.dart';
import 'package:doctor_appointment/data/models/dashboard.dart';
import 'package:doctor_appointment/data/models/department.dart';
import 'package:doctor_appointment/data/models/doctor.dart';
import 'package:doctor_appointment/data/repositories/dashboard_depository.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int page = 1;
  DashboardRepository dashboardRepository;

  DashboardBloc({required this.dashboardRepository})
      : super(DashboardInitial()) {
    on<DashboardInitialEvent>((event, emit) async {
      emit(DashboardLoading());
      Dashboard dashboard = await dashboardRepository.getDashboard(page);
      List<Department> departments = dashboard.departments;
      List<Doctor> doctors = dashboard.doctors;
      emit(DashboardLoaded(departments: departments, doctors: doctors));
    });

    on<DashboardReloadedEvent>((event, emit) async {

      DashboardLoaded dashboardLoaded = state as DashboardLoaded; 
      if(dashboardLoaded.hasReachedMax) {
        return;
      } 

      page++;
      Dashboard dashboard = await dashboardRepository.getDashboard(page);
      List<Doctor> loadedDoctors = dashboard.doctors;
      dashboardLoaded.doctors.addAll(loadedDoctors);      

      emit(dashboardLoaded.copyWith(doctors: dashboardLoaded.doctors, hasReachedMax: loadedDoctors.isEmpty));
    });
  }
}
