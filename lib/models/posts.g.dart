// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) {
  return Posts((json['data'] as List)
      ?.map((e) => e == null ? null : Post.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$PostsToJson(Posts instance) =>
    <String, dynamic>{'data': instance.data};

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(json['id'] as String, json['title'] as String,
      json['description'] as String);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description
    };
