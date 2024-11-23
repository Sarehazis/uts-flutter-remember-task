// dashboard_event.dart

abstract class DashboardEvent {}

class FetchScheduleEvent extends DashboardEvent {
  final String userId;

  FetchScheduleEvent(this.userId);
}

class FetchStatsEvent extends DashboardEvent {
  final String userId;

  FetchStatsEvent(this.userId);
}
