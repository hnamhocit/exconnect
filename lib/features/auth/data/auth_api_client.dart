import 'package:dio/dio.dart';
import 'package:flutter_learning/features/auth/dtos/login_dto.dart';
import 'package:flutter_learning/features/auth/dtos/register_dto.dart';

class AuthApiClient {
  AuthApiClient({required this.dio});

  final Dio dio;

  Future<dynamic> login(LoginDto loginDto) async {
    try {
      final response = await dio.post('/auth/login', data: loginDto.toJson());
      final data = response.data;
      return data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.toString());
      }
    }
  }

  Future<dynamic> register(RegisterDto registerDto) async {
    try {
      final response =
          await dio.post('/auth/register', data: registerDto.toJson());
      final data = response.data;
      return data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.toString());
      }
    }
  }
}
