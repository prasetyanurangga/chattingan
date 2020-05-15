// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chat_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChatModel _$UserChatModelFromJson(Map<String, dynamic> json) {
  return UserChatModel(
    json['message'] as String,
    json['success'] as bool,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserChatModelToJson(UserChatModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['_id'] as String,
    count: json['count'] as int,
    chats: (json['chats'] as List)
        ?.map(
            (e) => e == null ? null : Chats.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.id,
      'count': instance.count,
      'chats': instance.chats,
    };
