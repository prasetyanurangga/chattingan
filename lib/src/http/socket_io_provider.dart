import 'package:chattingan/src/constant/env.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';
class SocketIoProvider{
  connectSocketIO()
  {
    Socket socket = io(EnvValue.production.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,// optional
    });
    socket.connect();
    return socket;
  }
}