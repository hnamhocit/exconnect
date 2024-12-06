import 'package:flutter_learning/features/auth/data/auth_api_client.dart';
import 'package:flutter_learning/features/auth/data/auth_local_data_source.dart';
import 'package:flutter_learning/features/auth/dtos/login_dto.dart';
import 'package:flutter_learning/features/auth/dtos/register_dto.dart';
import 'package:flutter_learning/features/auth/response.dart';

class AuthRepository {
  final AuthApiClient authApiClient;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepository(
      {required this.authApiClient, required this.authLocalDataSource});

  Future<Response> login(
      {required String email, required String password}) async {
    final data =
        await authApiClient.login(LoginDto(email: email, password: password));

    if (data['error'] != null) {
      return FailureResponse(
          code: data['error']['code'], message: data['error']['message']);
    }

    await authLocalDataSource.saveTokens(
        data['data']['accessToken'], data['data']['accessToken']);

    return SuccessResponse(code: data['code'], data: data['data']);
  }

  Future<Response> register(
      {required String email, required String password}) async {
    final data = await authApiClient
        .register(RegisterDto(email: email, password: password));

    if (data['error'] != null) {
      return FailureResponse(
          code: data['error']['code'], message: data['error']['message']);
    }

    await authLocalDataSource.saveTokens(
        data['data']['accessToken'], data['data']['accessToken']);

    return SuccessResponse(code: data['code'], data: data['data']);
  }

  Response getTokens() {
    final tokens = authLocalDataSource.getTokens();

    if (tokens == null) {
      return FailureResponse(code: 401, message: 'Unauthorized token!');
    }

    return SuccessResponse(code: 200, data: tokens);
  }

  Future<Response> logout() async {
    try {
      await authLocalDataSource.deleteTokens();
      return SuccessResponse(code: 200, data: null);
    } catch (e) {
      return FailureResponse(code: 500, message: e.toString());
    }
  }
}
