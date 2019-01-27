import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

// flutter packages pub run build_runner watch

@JsonSerializable()
class Session {

  final String access_token; // ignore: non_constant_identifier_names
  final String refresh_token;
  final int expires_in;

  Session(this.access_token, this.refresh_token, this.expires_in);

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}