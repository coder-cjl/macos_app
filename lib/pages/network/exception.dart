import 'package:dio/dio.dart';

class ApiException implements Exception {
  int code;
  String message;
  late dynamic data;
  DioError? e;

  ApiException({
    required this.code,
    required this.message,
    this.data,
    this.e,
  });

  @override
  String toString() {
    return "Api Exception: [code]: $code, [message]: $message";
  }
}
