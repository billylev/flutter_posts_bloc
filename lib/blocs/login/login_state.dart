import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';

class LoginState extends BlocState {}

class LoginForm extends LoginState {}
class LoginLoading extends LoginState {}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}