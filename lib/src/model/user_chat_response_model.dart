
import 'package:chattingan/src/model/chat_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_chat_response_model.g.dart';

@JsonSerializable(explicitToJson: true)

class UserChatModel
{
  @JsonKey(name : "message")
  String message;

  @JsonKey(name : "success")
  bool success;

  @JsonKey(name : "data")
  List<Data> data;


  UserChatModel(
      this.message,
      this.success,
      this.data,
  );

  factory UserChatModel.fromJson(Map<String, dynamic> json) => _$UserChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserChatModelToJson(this);

  @override
  String toString() => 'Post { id: $message }';


}

@JsonSerializable()
class Data
{
  @JsonKey(name : "_id")
  String id;

  @JsonKey(name : "count")
  int count;

  @JsonKey(name : "chats")
  List<Chats> chats;

  Data({
    this.id,
    this.count,
    this.chats
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString() => 'Post { id: $id }';


}



