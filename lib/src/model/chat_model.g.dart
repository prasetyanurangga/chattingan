// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chats _$ChatsFromJson(Map<String, dynamic> json) {
  return Chats(
    message_id: json['_id'] as String,
    message: json['message'] as String,
    date: json['date'] as String,
    updatedAt: json['updatedAt'] as String,
    sender: json['sender'] as String,
    reciver: json['reciver'] as String,
    data_sender: (json['data_sender'] as List)
        ?.map((e) =>
            e == null ? null : Senders.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    data_file: (json['data_file'] as List)
        ?.map(
            (e) => e == null ? null : Files.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    is_read: json['is_read'] as bool,
  );
}

Map<String, dynamic> _$ChatsToJson(Chats instance) => <String, dynamic>{
      '_id': instance.message_id,
      'message': instance.message,
      'date': instance.date,
      'updatedAt': instance.updatedAt,
      'data_sender': instance.data_sender?.map((e) => e?.toJson())?.toList(),
      'data_file': instance.data_file?.map((e) => e?.toJson())?.toList(),
      'sender': instance.sender,
      'reciver': instance.reciver,
      'is_read': instance.is_read,
    };
