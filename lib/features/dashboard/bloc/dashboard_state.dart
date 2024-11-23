// dashboard_state.dart

abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardLoadedState extends DashboardState {
  final List<String> schedules; // Daftar jadwal
  final double studyProgress; // Progres belajar pengguna

  DashboardLoadedState({
    required this.schedules,
    required this.studyProgress,
  });
}

class DashboardErrorState extends DashboardState {
  final String errorMessage;

  DashboardErrorState(this.errorMessage);
}
