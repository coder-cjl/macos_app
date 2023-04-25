class ApiResponse {
  late int code;
  late String message;
  late dynamic data;

  ApiResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  bool isSuccessful() {
    return code == 200;
  }
}
