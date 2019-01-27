import 'package:flutter/material.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_state_builder.dart';
import 'package:flutter_posts_bloc/blocs/posts/posts_bloc.dart';
import 'package:flutter_posts_bloc/blocs/posts/posts_event.dart';
import 'package:flutter_posts_bloc/blocs/posts/posts_state.dart';
import 'package:flutter_posts_bloc/models/posts.dart';

class DashboardPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PostsList();
  }
}

class _PostsList extends StatefulWidget {
  @override
  _PostsListState createState() {
    return new _PostsListState();
  }
}

class _PostsListState extends State<_PostsList> {
  PostsBloc _postsBloc;

  @override
  void initState() {

    _postsBloc = BlocProvider.of<PostsBloc>(context);

    //_postsBloc.emitEvent(LoadPostsRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<PostsState>(
        bloc: _postsBloc,
        builder: (BuildContext context, PostsState state) {
          if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return _buildListView(context);
        });
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => _postsBloc.emitEvent(LoadPostsRequest()),
        child: StreamBuilder<Posts>(
            stream: _postsBloc.items,
            builder: (BuildContext context, AsyncSnapshot<Posts> snapshot) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data != null ? (snapshot.data.data != null ? snapshot.data.data.length : 0) : 0,
                  itemBuilder: (BuildContext context, index) {
                    return Column(children: <Widget>[
                      Text(snapshot.data.data[index].title),
                      Text(snapshot.data.data[index].description),
                      Divider(
                        height: 1.0,
                      ),
                    ]);
                  });
            }));
  }

}
