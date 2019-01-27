import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_posts_bloc/blocs/posts/posts_bloc.dart';
import 'package:flutter_posts_bloc/blocs/posts/posts_event.dart';
import 'package:flutter_posts_bloc/ui/dashboard/dashboard_page1.dart';
import 'package:flutter_posts_bloc/ui/dashboard/dashboard_page2.dart';
import 'package:flutter_posts_bloc/ui/dashboard/dashboard_page3.dart';
import 'package:flutter_posts_bloc/localizations.dart';

class DashboardScreen extends StatefulWidget {

  static const String route = '/dash';

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _currentIndex = 0;

  final List<Widget> _children = [
    DashboardPage1(),
    DashboardPage2(),
    DashboardPage3()
  ];

  PostsBloc _postsBloc = PostsBloc();

  @override
  void initState() {
    _postsBloc.emitEvent(LoadPostsRequest());
    super.initState();
  }

  @override
  void dispose() {
    _postsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            AppLocalizations.instance.text('title'),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:
              _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard),
              title: new Text(AppLocalizations.instance.text('page_one')),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.gesture),
              title: new Text(AppLocalizations.instance.text('page_two')),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.timelapse),
                title: Text(AppLocalizations.instance.text('page_three'))
            )
          ],
        ),
        body: BlocProvider<PostsBloc>(
          bloc: _postsBloc,
          child: _children[_currentIndex]
        )
      );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
