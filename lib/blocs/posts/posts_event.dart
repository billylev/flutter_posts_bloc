import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';

abstract class PostsEvent extends BlocEvent {
}

class LoadPostsRequest extends PostsEvent {}
