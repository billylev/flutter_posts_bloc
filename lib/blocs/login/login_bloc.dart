import 'package:flutter_posts_bloc/api/auth_api.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_event_state.dart';
import 'package:flutter_posts_bloc/blocs/login/login_event.dart';
import 'package:flutter_posts_bloc/blocs/login/login_state.dart';
import 'package:flutter_posts_bloc/blocs/session/session_bloc.dart';
import 'package:flutter_posts_bloc/blocs/session/session_event.dart';

class LoginBloc extends BlocEventStateBase<LoginEvent, LoginState> {

  final SessionBloc _sessionBloc;

  LoginBloc(this._sessionBloc)
      : super(initialState: LoginForm());

  @override
  Stream<LoginState> eventHandler(
      LoginEvent event, LoginState currentState) async* {
    if (event is LoginRequest) {

      yield LoginLoading();

      // login
      try {

        AuthApi authApi = AuthApi();
        var result = await authApi.loginEnum(event.username, event.password);

        if (result != null) {

          _sessionBloc.emitEvent(SessionLogin(result.access_token));
          yield LoginForm();
        }

      } catch (error) {
        yield LoginFailure(error.toString());
      }
    }
  }
}
