
import 'package:chattingan/src/model/sender_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_model.g.dart';

@JsonSerializable(explicitToJson: true)

class UsersModel
{
  @JsonKey(name : "message")
  String message;

  @JsonKey(name : "success")
  bool success;

  @JsonKey(name : "data")
  List<Senders> datauser;


  UsersModel(
      this.message,
      this.success,
      this.datauser,
  );

  factory UsersModel.fromJson(Map<String, dynamic> json) => _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);

  @override
  String toString() => 'Post { id: $message }';


}


