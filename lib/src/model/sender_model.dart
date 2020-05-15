import 'package:json_annotation/json_annotation.dart';

part 'sender_model.g.dart';

@JsonSerializable(explicitToJson: true)

@JsonSerializable()
class Senders
{
  @JsonKey(name : "_id")
  String id;

  @JsonKey(name : "email")
  String email;

  @JsonKey(name : "username")
  String username;

  @JsonKey(name : "is_online")
  bool is_online;

  Senders({
    this.id,
    this.email,
    this.username,
    this.is_online
  });

  factory Senders.fromJson(Map<String, dynamic> json) => _$SendersFromJson(json);

  Map<String, dynamic> toJson() => _$SendersToJson(this);

  @override
  String toString() => 'Post { id: $id }';


}