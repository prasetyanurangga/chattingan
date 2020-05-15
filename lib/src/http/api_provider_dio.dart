import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:chattingan/src/constant/env.dart';

import 'custom_exception.dart';

class ApiProvider {
  String token = '';


  final Dio _dio = Dio();

  void setToken(String token) {
    this.token = token;
  }

  Future<Map<String, dynamic>> post(String url, dynamic body) async {
    dynamic responseJson;
    _dio.options.baseUrl = EnvValue.development.baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers["content-type"] = "application/json";
          options.headers["accept"] = "application/json";
        }
    ));
    try {
      final Response response =
      await _dio.post(Uri.encodeFull(url), data: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url, {String token = '', dynamic query}) async {
    dynamic responseJson;
    try {
      _dio.options.baseUrl = EnvValue.development.baseUrl;
      _dio.interceptors.add(InterceptorsWrapper(
          onRequest: (Options options) async {
            options.headers["content-type"] = "application/json";
            options.headers["accept"] = "application/json";
          }
      ));
      final Response response = await _dio.get(Uri.encodeFull(url));

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson = json.decode(response.data.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}