// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Senders _$SendersFromJson(Map<String, dynamic> json) {
  return Senders(
    id: json['_id'] as String,
    email: json['email'] as String,
    username: json['username'] as String,
    is_online: json['is_online'] as bool,
  );
}

Map<String, dynamic> _$SendersToJson(Senders instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'is_online': instance.is_online,
    };
