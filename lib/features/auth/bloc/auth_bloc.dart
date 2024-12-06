import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/features/auth/data/auth_repository.dart';
import 'package:flutter_learning/features/auth/response.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthRegisterStarted>(_onRegisterStarted);
    on<AuthAuthenticateStarted>(_onAuthAuthenticateStarted);
    on<AuthLogoutStarted>(_onAuthLogoutStarted);
  }

  final AuthRepository authRepository;

  void _onLoginStarted(AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());

    final result = await authRepository.login(
        email: event.email, password: event.password);

    return switch (result) {
      SuccessResponse() => emit(AuthLoginSuccess()),
      FailureResponse() => emit(AuthLoginFailure(message: result.message)),
    };
  }

  void _onRegisterStarted(
      AuthRegisterStarted event, Emitter<AuthState> emit) async {
    emit(AuthRegisterInProgress());

    final result = await authRepository.register(
        email: event.email, password: event.password);

    return switch (result) {
      SuccessResponse() => emit(AuthRegisterSuccess()),
      FailureResponse() => emit(AuthRegisterFailure(message: result.message))
    };
  }

  void _onAuthAuthenticateStarted(
      AuthAuthenticateStarted event, Emitter<AuthState> emit) {
    final result = authRepository.getTokens();

    return switch (result) {
      SuccessResponse() => emit(
          AuthAuthenticateSuccess(
              accessToken: result.data.accessToken,
              refreshToken: result.data.refreshToken),
        ),
      FailureResponse() =>
        emit(AuthAuthenticateFailure(message: result.message)),
    };
  }

  void _onAuthLogoutStarted(
      AuthLogoutStarted event, Emitter<AuthState> emit) async {
    final result = await authRepository.logout();

    return switch (result) {
      SuccessResponse() => emit(AuthLogoutSuccess()),
      FailureResponse() => emit(AuthLogoutFailure(message: result.message))
    };
  }
}
