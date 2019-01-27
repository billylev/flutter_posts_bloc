import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';

class PostsState extends BlocState {}

class PostsEmpty extends PostsState {}
class PostsLoading extends PostsState {}
class PostsLoaded extends PostsState {}
class PostsFailure extends PostsState {
  final String error;
  PostsFailure(this.error);
}