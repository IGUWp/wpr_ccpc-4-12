import 'dart:io';

import 'package:dio/dio.dart';

enum HttpType {
  HttpTypePost,
  HttpTypeGet,
}

class http {
  // static String baseurl = "http://localhost:5150/api";
  static String baseurl = "http://82.156.128.67:8887/api";
  static String? token;
  static Dio? dio_instance;
  static Dio? getdio() {
    dio_instance = Dio();
    return dio_instance;
  }

  static Future<Response> get(String url,
      {Map<String, dynamic>? queryparameters}) async {
    return await _sentHttpRequest(HttpType.HttpTypeGet, baseurl + url,
        queryparameters: queryparameters);
  }

  static Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    return await _sentHttpRequest(HttpType.HttpTypePost, baseurl + url,
        data: data);
  }

  static _sentHttpRequest(HttpType type, String url,
      {Map<String, dynamic>? queryparameters,
      Map<String, dynamic>? data}) async {
    try {
      Options options =
          Options(headers: {HttpHeaders.authorizationHeader: token});
      switch (type) {
        case HttpType.HttpTypeGet:
          var res = await getdio()?.get(url,
              options: options, queryParameters: queryparameters, data: data);
          return res;
        case HttpType.HttpTypePost:
          var res = await getdio()?.post(url, options: options, data: data);
          return res;
        default:
          throw Exception('报错了：请求只支持get和post');
      }
    } catch (e) {
      print("报错:$e");
    }
  }
}
