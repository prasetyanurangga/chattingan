import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_event.dart';
import 'package:chattingan/src/bloc/authentication/authentication_state.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:chattingan/src/http/socket_io_provider.dart';
import 'package:chattingan/src/local/model/user_model.dart';
import 'package:chattingan/src/repository/authentication/authentication_repository.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;


  AuthenticationBloc({@required this.authenticationRepository})
      : assert(authenticationRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AuthStarted) {


      final bool hasUser = await authenticationRepository.hasUser();

      if (hasUser) {
        Socket socket;
        List<UserModel> userAll = await authenticationRepository.fetchAllUser();
        String userId = userAll[0].id;
        SocketIoProvider socketIoProvider = new SocketIoProvider();

        socket = socketIoProvider.connectSocketIO();
        socket.on('connect', (_) {
          print("connect");
          socket.emit('userConnected', { 'customId':userId });
        });

        socket.on('disconnect', (_) {
          print("disconnect");
          socket.emit('userDisconnected', { 'customId':userId });
        });
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();

        UserModel userModel = new UserModel();
        userModel.id = event.id;
        userModel.username = event.username;
        userModel.email = event.email;
        await authenticationRepository.persistUser(userModel);
        yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authenticationRepository.deleteUser();
      yield AuthenticationUnauthenticated();
    }
  }
}