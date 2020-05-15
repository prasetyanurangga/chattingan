
import 'package:chattingan/src/model/file_model.dart';
import 'package:chattingan/src/model/sender_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_response_model.g.dart';

@JsonSerializable(explicitToJson: true)

class FileResponseModel
{
  @JsonKey(name : "message")
  String message;

  @JsonKey(name : "success")
  bool success;

  @JsonKey(name : "data")
  List<Files> data_file;


  FileResponseModel(
      this.message,
      this.success,
      this.data_file,
      );

  factory FileResponseModel.fromJson(Map<String, dynamic> json) => _$FileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileResponseModelToJson(this);

  @override
  String toString() => 'Post { id: $message }';


}


