import 'package:chattingan/src/model/file_model.dart';
import 'package:chattingan/src/model/sender_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable(explicitToJson: true)

@JsonSerializable()
class Chats
{
  @JsonKey(name : "_id")
  String message_id;

  @JsonKey(name : "message")
  String message;

  @JsonKey(name : "date")
  String date;

  @JsonKey(name : "updatedAt")
  String updatedAt;

  @JsonKey(name : "data_sender")
  List<Senders> data_sender;

  @JsonKey(name : "data_file")
  List<Files> data_file;

  @JsonKey(name : "sender")
  String sender;

  @JsonKey(name : "reciver")
  String reciver;

  @JsonKey(name : "is_read")
  bool is_read;

  Chats({
    this.message_id,
    this.message,
    this.date,
    this.updatedAt,
    this.sender,
    this.reciver,
    this.data_sender,
    this.data_file,
    this.is_read,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => _$ChatsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatsToJson(this);

  @override
  String toString() => 'Post { id: $message_id }';


}