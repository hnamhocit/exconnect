part of 'auth_bloc.dart';

class AuthEvent {}

// LOGIN
class AuthLoginStarted extends AuthEvent {
  AuthLoginStarted({required this.email, required this.password});

  final String email;
  final String password;
}

// REGISTER
class AuthRegisterStarted extends AuthEvent {
  AuthRegisterStarted({required this.email, required this.password});

  final String email;
  final String password;
}

// AUTHENTICATE
class AuthAuthenticateStarted extends AuthEvent {}

// LOGOUT
class AuthLogoutStarted extends AuthEvent {}
