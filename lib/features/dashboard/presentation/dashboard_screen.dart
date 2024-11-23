import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_task/features/auth/bloc/auth_bloc.dart';
import 'package:remember_task/features/auth/bloc/auth_state.dart';
import 'package:remember_task/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:remember_task/features/dashboard/bloc/dashboard_event.dart';
import 'package:remember_task/features/dashboard/bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          return BlocProvider(
            create: (_) =>
                DashboardBloc()..add(FetchScheduleEvent(authState.user.uid)),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                    'Welcome, ${authState.userName}'), // Menampilkan nama pengguna
              ),
              body: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DashboardLoadedState) {
                    return Column(
                      children: [
                        const Text('Jadwal Anda:',
                            style: TextStyle(fontSize: 18)),
                        ...state.schedules.map((schedule) => Text(schedule)),
                        Text('Progres Belajar: ${state.studyProgress}%',
                            style: const TextStyle(fontSize: 18)),
                      ],
                    );
                  } else if (state is DashboardErrorState) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  }
                  return Container(); // Default state
                },
              ),
            ),
          );
        }
        return const Center(
            child: Text('Please log in to access the dashboard.'));
      },
    );
  }
}
