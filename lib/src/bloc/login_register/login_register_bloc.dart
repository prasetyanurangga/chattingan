import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chattingan/src/bloc/login_register/login_register_event.dart';
import 'package:chattingan/src/bloc/login_register/login_register_state.dart';
import 'package:chattingan/src/model/login_register_response_model.dart';
import 'package:chattingan/src/repository/login_register/login_register_repository.dart';
import 'package:chattingan/src/repository/login_register/login_register_repository.dart';
import 'package:http/http.dart';
import 'package:chattingan/src/bloc/authentication/authentication_bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_event.dart';
import 'package:chattingan/src/http/response_data.dart';
import 'package:meta/meta.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  final LoginRegisterRepository loginRegisterRepository;
  final AuthenticationBloc authenticationBloc;

  LoginRegisterBloc({
    @required this.loginRegisterRepository,
    @required this.authenticationBloc,
  });

  @override
  LoginRegisterState get initialState => LoginRegisterInitial();

  @override
  Stream<LoginRegisterState> mapEventToState(LoginRegisterEvent event) async* {
    if (event is LoginButtonPressed) {
      print("Test");
      yield LoginRegisterLoading();

      try {
        final ResponseData<LoginRegisterResponseModel> response =
        await loginRegisterRepository.logins(event.email, event.password);
        print("hai");
        print(response);
        if (response.status == Status.ConnectivityError) {
          //Internet problem
          yield const LoginRegisterFailure(error: "");
        }
        if (response.status == Status.Success) {
          print("Berhasil");
          print(response.message);
          authenticationBloc.add(LoggedIn(id: response.data.data.id.toString(), email: response.data.data.email, username: response.data.data.nama.toString()));
          yield LoginRegisterSuccess();
        } else {
          yield LoginRegisterFailure(error: response.message);
        }
      } catch (error) {
        yield LoginRegisterFailure(error: error.toString());
      }
    }
    else if (event is RegisterButtonPressed) {
      print("Test");
      yield LoginRegisterLoading();

      try {
        final ResponseData<LoginRegisterResponseModel> response =
        await loginRegisterRepository.registers(event.email, event.password, event.username);
        print("hai");
        print(response);
        if (response.status == Status.ConnectivityError) {
          //Internet problem
          yield const LoginRegisterFailure(error: "");
        }
        if (response.status == Status.Success) {
          yield LoginRegisterSuccess();
        } else {
          yield LoginRegisterFailure(error: response.message);
        }
      } catch (error) {
        yield LoginRegisterFailure(error: error.toString());
      }
    }
    else if(event is LogOutButtonPressed)
      {
        authenticationBloc.add(LoggedOut());
        yield LogoutSuccess();
      }
  }
}