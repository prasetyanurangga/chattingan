// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    json['message'] as String,
    json['success'] as bool,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Chats.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
    };
