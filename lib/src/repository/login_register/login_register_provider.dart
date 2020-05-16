import 'dart:async';
import 'dart:convert';

import 'package:chattingan/src/http/api_provider.dart';
import 'package:meta/meta.dart';

class LoginRegisterProvider {
  LoginRegisterProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  final String baseUrl;

  ApiProvider apiProvider;

  Future<Map<String, dynamic>> login(String email, String password) async {
    print(Uri.encodeFull(('$baseUrl/login')));
    try {
      final String data = json.encode({'email': email, 'password': password});
      var response = await apiProvider.post('$baseUrl/login', data);
      return response;
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, String username) async {
    print(Uri.encodeFull(('$baseUrl/register')));

    try {
      final String data = json.encode({'email': email, 'password': password, 'username' : username});
      print(data);
      var response = await apiProvider.post('$baseUrl/register', data);
      return response;
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}