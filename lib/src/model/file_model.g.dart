// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Files _$FilesFromJson(Map<String, dynamic> json) {
  return Files(
    id: json['_id'] as String,
    name: json['name'] as String,
    extension: json['extension'] as String,
    size: json['size'] as int,
    data_binary: json['data_binary'] as String,
  );
}

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'extension': instance.extension,
      'size': instance.size,
      'data_binary': instance.data_binary,
    };
