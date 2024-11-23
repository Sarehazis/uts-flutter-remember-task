// auth_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:remember_task/features/auth/data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginEvent>(_mapLoginEventToState);
    on<AuthRegisterEvent>(_mapRegisterEventToState);
    on<AuthLogoutEvent>(_mapLogoutEventToState);
  }

  Future<void> _mapLoginEventToState(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user, user.displayName ?? ''));
      } else {
        emit(AuthFailure("Login failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _mapRegisterEventToState(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.register(
          event.email, event.password, event.name);
      if (user != null) {
        emit(
            AuthAuthenticated(user, event.name)); // Menggunakan nama dari event
      } else {
        emit(AuthFailure("Registration failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _mapLogoutEventToState(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
