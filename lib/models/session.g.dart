// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(json['access_token'] as String,
      json['refresh_token'] as String, json['expires_in'] as int);
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'expires_in': instance.expires_in
    };
