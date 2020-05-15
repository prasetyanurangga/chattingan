
import 'package:json_annotation/json_annotation.dart';

part 'login_register_response_model.g.dart';

@JsonSerializable(explicitToJson: true)

class LoginRegisterResponseModel
{
  @JsonKey(name : "message")
  String message;

  @JsonKey(name : "success")
  bool success;

  @JsonKey(name : "data")
  Data data;


  LoginRegisterResponseModel(
      this.message,
      this.success,
      this.data,
  );

  factory LoginRegisterResponseModel.fromJson(Map<String, dynamic> json) => _$LoginRegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRegisterResponseModelToJson(this);

  @override
  String toString() => 'Post { id: $message }';


}

@JsonSerializable()
class Data
{
  @JsonKey(name : "_id")
  String id;

  @JsonKey(name : "email")
  String email;

  @JsonKey(name : "username")
  String nama;

  Data(
      this.id,
      this.email,
      this.nama,
      );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString() => 'Post { id: $id }';


}
