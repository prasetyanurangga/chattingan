// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileResponseModel _$FileResponseModelFromJson(Map<String, dynamic> json) {
  return FileResponseModel(
    json['message'] as String,
    json['success'] as bool,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Files.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FileResponseModelToJson(FileResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'data': instance.data_file?.map((e) => e?.toJson())?.toList(),
    };
