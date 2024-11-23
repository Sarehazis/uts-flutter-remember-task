// dashboard_bloc.dart

// ignore_for_file: override_on_non_overriding_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DashboardBloc() : super(DashboardInitialState());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is FetchScheduleEvent) {
      yield DashboardLoadingState();
      try {
        // Mendapatkan jadwal dari Firebase Firestore
        var scheduleSnapshot = await _firestore
            .collection('schedules')
            .where('userId', isEqualTo: event.userId)
            .get();

        List<String> schedules = scheduleSnapshot.docs
            .map((doc) => doc['subject'] as String)
            .toList();

        yield DashboardLoadedState(
            schedules: schedules, studyProgress: 75.0); // contoh progres 75%
      } catch (e) {
        yield DashboardErrorState(e.toString());
      }
    } else if (event is FetchStatsEvent) {
      yield DashboardLoadingState();
      try {
        // Mendapatkan statistik dari Firebase
        var statsSnapshot =
            await _firestore.collection('study_stats').doc(event.userId).get();

        double studyProgress = statsSnapshot.data()?['progress'] ?? 0.0;

        yield DashboardLoadedState(schedules: [], studyProgress: studyProgress);
      } catch (e) {
        yield DashboardErrorState(e.toString());
      }
    }
  }
}
