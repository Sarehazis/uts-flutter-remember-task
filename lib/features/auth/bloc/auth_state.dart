import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String userName;

  AuthAuthenticated(this.user, this.userName);
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
