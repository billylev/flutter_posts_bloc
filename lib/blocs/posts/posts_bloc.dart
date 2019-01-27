import 'package:flutter_posts_bloc/api/posts_api.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';
import 'package:flutter_posts_bloc/blocs/posts/posts_event.dart';
import 'package:flutter_posts_bloc/blocs/posts/posts_state.dart';
import 'package:flutter_posts_bloc/models/posts.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc extends BlocEventStateBase<PostsEvent, PostsState> {

  BehaviorSubject<Posts> _itemsController = BehaviorSubject<Posts>();
  Stream<Posts> get items => _itemsController;

  @override
  Stream<PostsState> eventHandler(
      PostsEvent event, PostsState currentState) async* {

    if (event is LoadPostsRequest) {

      yield PostsLoading();

      try {

        PostApi postsApi = PostApi();
        var result = await postsApi.getPostsEnum();

        if (result != null) {
          _itemsController.add(result);
          yield PostsLoaded();
        }


      } catch (error) {
        yield PostsFailure(error.toString());
      }
    }
  }
}