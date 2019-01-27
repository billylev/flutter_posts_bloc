import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';

abstract class SessionEvent extends BlocEvent {
}

class SessionStarted extends SessionEvent {}
class SessionLogin extends SessionEvent {
  String token;
  SessionLogin(this.token);
}
class SessionLogout extends SessionEvent {}
