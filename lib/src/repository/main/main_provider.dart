import 'dart:async';
import 'dart:convert';

import 'package:chattingan/src/http/api_provider.dart';
import 'package:chattingan/src/http/response_data.dart';
import 'package:chattingan/src/model/login_register_response_model.dart';
import 'package:meta/meta.dart';

class MainProvider {
  MainProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  final String baseUrl;

  ApiProvider apiProvider;

  Future<Map<String, dynamic>> getAllChat(String id, String filterText) async {
    print(Uri.encodeFull(('$baseUrl/get_all_chat')));
    try {
      final String data = json.encode({'id': id, 'filter_text' : filterText});
      var response = await apiProvider.post('$baseUrl/get_all_chat', data);
      print(response);
      return response;
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> getChat(String reciverId, String senderId) async {
    print(Uri.encodeFull(('$baseUrl/get_all_chat/$reciverId/$senderId')));
    try {
      final String data = json.encode({'reciverid': reciverId, 'senderid' : senderId});
      var response = await apiProvider.post('$baseUrl/get_chat', data);
      print(response);
      return response;
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> getAllUser(String filterText, String user_id) async {
    print(Uri.encodeFull(('$baseUrl/get_all_user')));
    try {
      final String data = json.encode({'filter_text' : filterText, 'user_id' : user_id});
      var response = await apiProvider.post('$baseUrl/get_all_user', data);
      //print(response);
      return response;
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> getFile(String fileId) async {
    print(Uri.encodeFull(('$baseUrl/get_all_user')));
    try {
      final String data = json.encode({'id' : fileId});
      var response = await apiProvider.post('$baseUrl/get_file', data);
      //print(response);
      return response;
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}