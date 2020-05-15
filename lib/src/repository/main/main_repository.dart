
import 'package:chattingan/src/constant/env.dart';
import 'package:chattingan/src/http/api_provider.dart';
import 'package:chattingan/src/http/response_data.dart';
import 'package:chattingan/src/local/model/user_model.dart';
import 'package:chattingan/src/model/chat_model.dart';
import 'package:chattingan/src/model/chat_response_model.dart';
import 'package:chattingan/src/model/file_response_model.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/model/user_response_model.dart';
import 'package:chattingan/src/repository/authentication/authentication_repository.dart';
import 'package:chattingan/src/repository/main/main_provider.dart';
import 'package:chattingan/src/utils/internet_check.dart';
import 'package:meta/meta.dart';


class MainRepository {
  final ApiProvider apiProvider;
  MainProvider mainProvider;
  InternetCheck internetCheck;
  Env env;
  AuthenticationRepository authenticationRepository = AuthenticationRepository();

  MainRepository(
      {@required this.env,
        @required this.apiProvider,
        @required this.internetCheck}) {
    mainProvider =
        MainProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<ResponseData<UserChatModel>> getAllChats({String filterText = ""}) async {
    List<UserModel> userAll = await authenticationRepository.fetchAllUser();
    String userid = userAll[0].id;
    print(userAll[0].id);
    Map<String,dynamic> response = await mainProvider.getAllChat(userid, filterText);
    UserChatModel userChatModel = UserChatModel.fromJson(response);
    if (UserChatModel == null) {
      return ResponseData.connectivityError();
    }
    if (userChatModel.success) {
      return ResponseData.success(userChatModel);
    } else {
      return ResponseData.error("Error");
    }
  }

  Future<ResponseData<ChatModel>> getChats({String senderId = ""}) async {
    List<UserModel> userAll = await authenticationRepository.fetchAllUser();
    String userid = userAll[0].id;
    print(userAll[0].id);
    Map<String,dynamic> response = await mainProvider.getChat(userid, senderId);
    ChatModel chatModel = ChatModel.fromJson(response);
    if (chatModel == null) {
      return ResponseData.connectivityError();
    }
    if (chatModel.success) {
      return ResponseData.success(chatModel);
    } else {
      return ResponseData.error("Error");
    }
  }

  Future<ResponseData<UsersModel>> getAllUsers({String filterText = ""}) async {
    List<UserModel> userAll = await authenticationRepository.fetchAllUser();
    String userid = userAll[0].id;
    Map<String,dynamic> response = await mainProvider.getAllUser(filterText, userid);
    print(response);
    UsersModel usersModel = UsersModel.fromJson(response);
    if (usersModel == null) {
      return ResponseData.connectivityError();
    }
    if (usersModel.success) {
      return ResponseData.success(usersModel);
    } else {
      return ResponseData.error("Error");
    }
  }

  Future<ResponseData<FileResponseModel>> getFiles({String fileId = ""}) async {
    Map<String,dynamic> response = await mainProvider.getFile(fileId);
    print(response);
    FileResponseModel fileResponseModel = FileResponseModel.fromJson(response);
    if (fileResponseModel == null) {
      return ResponseData.connectivityError();
    }
    if (fileResponseModel.success) {
      return ResponseData.success(fileResponseModel);
    } else {
      return ResponseData.error("Error");
    }
  }
}