import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_state_builder.dart';
import 'package:flutter_posts_bloc/blocs/login/login_bloc.dart';
import 'package:flutter_posts_bloc/blocs/login/login_event.dart';
import 'package:flutter_posts_bloc/blocs/login/login_state.dart';
import 'package:flutter_posts_bloc/blocs/session/session_bloc.dart';
import 'package:flutter_posts_bloc/localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {

  SessionBloc _sessionBloc;
  LoginBloc _loginBloc;

  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;

  @override
  void initState() {
    _sessionBloc = BlocProvider.of<SessionBloc>(context);
    _loginBloc = LoginBloc(_sessionBloc);
    super.initState();
  }

  Widget _pageToDisplay(BuildContext context) {

    return BlocEventStateBuilder<LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state)
    {

      if (state is LoginLoading) {
        return _loadingView;
      }

      if (state is LoginForm || state is LoginFailure) {

        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.instance.text('login_error'))
              ),
            );
          });
        }

        return Form(
            key: _formKey,
            child: _loginView(
                context) // We'll build this out in the next steps!
        );
      }

    });
  }

  Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget _loginView(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.instance.text('login_username'),
                    hintText:
                        AppLocalizations.instance.text('login_username_hint'),
                  ),
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.instance.text('login_enter_username')
                      : null,
                  onSaved: (val) => _username = val),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.instance.text('login_password'),
                  hintText:
                      AppLocalizations.instance.text('login_password_hint'),
                ),
                validator: (val) => val.isEmpty
                    ? AppLocalizations.instance.text('login_enter_password')
                    : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment(0.0, 1.0),
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _loginBloc.emitEvent(LoginRequest(_username, _password));
                          }
                        },
                        child: Text(
                            AppLocalizations.instance.text('login_button')),
                      )))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // hide the back
          title: Text(
            AppLocalizations.instance.text('login_title'),
          ),
        ),
        body: _pageToDisplay(context));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
