// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) {
  return UsersModel(
    json['message'] as String,
    json['success'] as bool,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Senders.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'data': instance.datauser?.map((e) => e?.toJson())?.toList(),
    };
