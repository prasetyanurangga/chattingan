
import 'package:chattingan/src/constant/env.dart';
import 'package:chattingan/src/http/api_provider.dart';
import 'package:chattingan/src/http/response_data.dart';
import 'package:chattingan/src/model/login_register_response_model.dart';
import 'package:chattingan/src/repository/login_register/login_register_provider.dart';
import 'package:chattingan/src/utils/internet_check.dart';
import 'package:meta/meta.dart';


class LoginRegisterRepository {
  final ApiProvider apiProvider;
  LoginRegisterProvider loginRegisterProvider;
  InternetCheck internetCheck;
  Env env;

  LoginRegisterRepository(
      {@required this.env,
        @required this.apiProvider,
        @required this.internetCheck}) {
    loginRegisterProvider =
        LoginRegisterProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<ResponseData<LoginRegisterResponseModel>> logins(String email, String password) async {
    Map<String,dynamic> response = await loginRegisterProvider.login(email, password);
    LoginRegisterResponseModel loginResponseModel = LoginRegisterResponseModel.fromJson(response);
    if (loginResponseModel == null) {
      return ResponseData.connectivityError();
    }
    if (loginResponseModel.success) {
      return ResponseData.success(loginResponseModel);
    } else {
      return ResponseData.error("Error");
    }
  }

  Future<ResponseData<LoginRegisterResponseModel>> registers(String email, String password, String username) async {
    Map<String,dynamic> response = await loginRegisterProvider.register(email, password, username);
    LoginRegisterResponseModel loginResponseModel = LoginRegisterResponseModel.fromJson(response);
    if (loginResponseModel == null) {
      return ResponseData.connectivityError();
    }
    if (loginResponseModel.success) {
      return ResponseData.success(loginResponseModel);
    } else {
      return ResponseData.error("Error");
    }
  }
}