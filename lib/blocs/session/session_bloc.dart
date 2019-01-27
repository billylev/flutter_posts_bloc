import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';
import 'package:flutter_posts_bloc/blocs/session/session_event.dart';
import 'package:flutter_posts_bloc/blocs/session/session_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionBloc extends BlocEventStateBase<SessionEvent, SessionState> {

  SessionBloc()
      : super(initialState: SessionUninitialized());

  @override
  Stream<SessionState> eventHandler(
      SessionEvent event, SessionState currentState) async* {

    if (event is SessionStarted) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var result = prefs.getString('token');

      // show splash screen
      await Future.delayed(Duration(seconds: 2));

      if (result != null) {
        yield SessionAuthenticated();
      }
      else {
        yield SessionUnAuthenticated();
      }
    }

    if (event is SessionLogin) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", event.token);

      yield SessionAuthenticated();
    }

    if (event is SessionLogout) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");

      yield SessionUnAuthenticated();
    }
  }
}
