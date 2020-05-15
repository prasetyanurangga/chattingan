
import 'package:chattingan/src/model/chat_model.dart';
import 'package:chattingan/src/model/sender_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_response_model.g.dart';

@JsonSerializable(explicitToJson: true)

class ChatModel
{
  @JsonKey(name : "message")
  String message;

  @JsonKey(name : "success")
  bool success;

  @JsonKey(name : "data")
  List<Chats> data;


  ChatModel(
      this.message,
      this.success,
      this.data,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
  String toString() => 'Post { id: $message }';


}


