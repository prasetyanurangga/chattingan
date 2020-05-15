// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRegisterResponseModel _$LoginRegisterResponseModelFromJson(
    Map<String, dynamic> json) {
  return LoginRegisterResponseModel(
    json['message'] as String,
    json['success'] as bool,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginRegisterResponseModelToJson(
        LoginRegisterResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'data': instance.data?.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['_id'] as String,
    json['email'] as String,
    json['username'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'username': instance.nama,
    };
