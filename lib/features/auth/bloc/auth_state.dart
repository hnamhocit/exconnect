part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

// LOGIN

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  final String message;

  AuthLoginFailure({required this.message});
}

// REGISTER

class AuthRegisterInProgress extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterFailure extends AuthState {
  final String message;

  AuthRegisterFailure({required this.message});
}

// AUTHENTICATED

class AuthAuthenticateSuccess extends AuthState {
  final String accessToken;
  final String refreshToken;

  AuthAuthenticateSuccess(
      {required this.accessToken, required this.refreshToken});
}

class AuthAuthenticateFailure extends AuthState {
  final String message;

  AuthAuthenticateFailure({required this.message});
}

// LOGOUT
class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {
  final String message;

  AuthLogoutFailure({required this.message});
}
