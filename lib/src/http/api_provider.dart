import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:chattingan/src/model/login_register_response_model.dart';

import 'custom_exception.dart';

class ApiProvider {

  final http = https.Client();

  String token = '';

  void setToken(String token) {
    this.token = token;
  }

  Future<dynamic> post(String url, dynamic body,
      {String token = ''}) async {
    dynamic responseJson;
    try {
      final dynamic response =
      await http.post(Uri.encodeFull(url), body: body, headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      var response = await http.get(Uri.encodeFull(url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }




  dynamic _response(https.Response response) {
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}