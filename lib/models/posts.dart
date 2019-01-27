import 'package:json_annotation/json_annotation.dart';

part 'posts.g.dart';

// flutter packages pub run build_runner watch

@JsonSerializable()
class Posts {

  final List<Post> data;

  Posts(this.data);

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);
}

@JsonSerializable()
class Post {

  final String id;
  final String title;
  final String description;

  Post(this.id, this.title, this.description);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}