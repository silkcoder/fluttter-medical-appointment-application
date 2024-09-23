import 'package:doctor_appointment/data/data_providers/dashboard_data_provider.dart';
import 'package:doctor_appointment/data/models/dashboard.dart';
import 'package:doctor_appointment/data/models/department.dart';

class DashboardRepository {
  final DashboardDataProvider dashboardDataProvider;
  DashboardRepository({required this.dashboardDataProvider});

  Future<Dashboard> getDashboard() async {
    return await dashboardDataProvider.getDashboardData();
  }
}