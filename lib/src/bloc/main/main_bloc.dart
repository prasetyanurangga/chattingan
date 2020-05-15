import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:bloc/bloc.dart';
import 'package:chattingan/src/bloc/main/main_event.dart';
import 'package:chattingan/src/bloc/main/main_state.dart';
import 'package:chattingan/src/http/response_data.dart';
import 'package:chattingan/src/model/chat_response_model.dart';
import 'package:chattingan/src/model/file_response_model.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/model/user_response_model.dart';
import 'package:chattingan/src/repository/main/main_repository.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository mainRepository;

  MainBloc({
    @required this.mainRepository
  });

  @override
  MainState get initialState => MainInitial();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is FetchAllChat) {
      print("Test");
      yield MainLoading();
      try {
        final ResponseData<UserChatModel> response =
        await mainRepository.getAllChats(filterText: event.filterText);
        if (response.status == Status.ConnectivityError) {
          //Internet problem
          yield const MainFailure(error: "");
        }
        if (response.status == Status.Success) {
          yield MainSuccessUserChat(userChatModel: response.data);
        } else {
          yield MainFailure(error: response.message);
        }
      } catch (error) {
        yield MainFailure(error: error.toString());
      }
    }
    else if (event is FetchChat) {
      print("Test");
      yield MainLoading();
      try {
        final ResponseData<ChatModel> response =
        await mainRepository.getChats(senderId: event.senderId);
        if (response.status == Status.ConnectivityError) {
          //Internet problem
          yield const MainFailure(error: "");
        }
        if (response.status == Status.Success) {
          yield MainSuccessChat(chatModel: response.data);
        } else {
          yield MainFailure(error: response.message);
        }
      } catch (error) {
        yield MainFailure(error: error.toString());
      }
    }
    else if (event is FetchAllUser) {
      print("Test");
      yield MainLoading();
      try {
        final ResponseData<UsersModel> response =
        await mainRepository.getAllUsers(filterText: event.filterText);
        print("status nya");
        print(response.status);
        if (response.status == Status.ConnectivityError) {
          //Internet problem
          yield const MainFailure(error: "");
        }
        if (response.status == Status.Success) {
          yield MainSuccessUser(usersModel: response.data);
        } else {
          yield MainFailure(error: response.message);
        }
      } catch (error) {
        yield MainFailure(error: error.toString());
      }
    }

  }
} 