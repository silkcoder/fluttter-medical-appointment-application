part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class DashboardInitialEvent extends DashboardEvent {
  DashboardInitialEvent();
}

final class DashboardReloadedEvent extends DashboardEvent {
  DashboardReloadedEvent();
}