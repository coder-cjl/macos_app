import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chatgpt_mac/pages/network/response.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';

class Api {
  final dio = Dio();

  Api();

  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request(
      path,
      "GET",
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<ApiResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return _request(
      path,
      "POST",
      data: data,
      headers: headers,
    );
  }

  Future<ApiResponse> _request(
    String path,
    String method, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    try {
      path = "https://api.openai.com/$path";
      var sendHeader = makeHeaders(headers);
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          return UserOpenAiUtils.instance.user?.proxy ?? "";
        };
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
        return client;
      };

      var res = await dio.request(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          headers: sendHeader,
          method: method,
          responseType: ResponseType.json,
        ),
      );
      dio.close();
      return ApiResponse(
        code: 200,
        message: "请求成功",
        data: res.data,
      );
    } on DioError catch (e) {
      if (e.response != null) {
        var statusCode = e.response?.statusCode;
        var statusMessage = e.response?.statusMessage;
        if (e.response?.data["error"]["message"] != null) {
          statusMessage = e.response?.data["error"]["message"];
        }
        // var exception =
        //     ApiException(code: statusCode!, message: statusMessage!, e: e);
        // throw exception;
        print("Api exception [code]: $statusCode, [message]: $statusMessage");
        return ApiResponse(
          code: statusCode!,
          message: statusMessage!,
          data: e.response?.data!,
        );
      }
    }
    return ApiResponse(
      code: -1,
      message: "请求失败",
      data: {},
    );
  }

  makeHeaders(Map<String, dynamic>? addHeaders) {
    var headers = <String, dynamic>{};
    var token = UserOpenAiUtils.instance.user?.token;
    headers["Authorization"] = "Bearer $token";
    if (addHeaders != null) {
      headers.addAll(addHeaders);
    }
    return headers;
  }
}
