
import 'package:json_annotation/json_annotation.dart';

part 'like_model.g.dart';

@JsonSerializable(explicitToJson: true)

class LikeModel
{
  @JsonKey(name : "nama")
  String nama;

  @JsonKey(name : "keterangan")
  String keterangan;


  LikeModel(
      this.nama,
      this.keterangan,
      );

//  factory LikeModel.fromJson(Map<String, dynamic> json) => _$LikeModelFromJson(json);
//
//  Map<String, dynamic> toJson() => _$LikeModelToJson(this);
//
//  @override
//  String toString() => 'Post { id: $message }';


}
