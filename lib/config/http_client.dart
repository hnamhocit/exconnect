import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://192.168.100.15:3000/',
    connectTimeout: const Duration(seconds: 5),
  ),
);
