import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';

class SessionState extends BlocState {}

class SessionUninitialized extends SessionState {}
class SessionAuthenticated extends SessionState {}
class SessionUnAuthenticated extends SessionState {}
