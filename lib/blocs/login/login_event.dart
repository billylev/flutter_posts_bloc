import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';

abstract class LoginEvent extends BlocEvent {
}

class LoginRequest extends LoginEvent {
  final String username;
  final String password;

  LoginRequest(this.username, this.password);
}