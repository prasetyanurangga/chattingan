
import 'package:chattingan/src/model/chat_response_model.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/model/user_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainSuccessUserChat extends MainState {
  final  UserChatModel userChatModel;

  MainSuccessUserChat({@required this.userChatModel});

}

class MainSuccessUser extends MainState {
  final  UsersModel usersModel;

  MainSuccessUser({@required this.usersModel});

}

class MainSuccessChat extends MainState {
  final  ChatModel chatModel;

  MainSuccessChat({@required this.chatModel});

}

class MainFailure extends MainState {
  final String error;

  const MainFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MainFailure { error: $error }';
}
