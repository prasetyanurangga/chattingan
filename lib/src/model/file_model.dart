import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable(explicitToJson: true)

@JsonSerializable()
class Files
{
  @JsonKey(name : "_id")
  String id;

  @JsonKey(name : "name")
  String name;

  @JsonKey(name : "extension")
  String extension;

  @JsonKey(name : "size")
  int size;

  @JsonKey(name : "data_binary")
  String data_binary;

  Files({
    this.id,
    this.name,
    this.extension,
    this.size,
    this.data_binary
  });

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);

  Map<String, dynamic> toJson() => _$FilesToJson(this);

  @override
  String toString() => 'Post { id: $id }';


}