import 'package:flutter/material.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_posts_bloc/blocs/session/session_bloc.dart';
import 'package:flutter_posts_bloc/blocs/session/session_event.dart';
import 'package:flutter_posts_bloc/localizations.dart';

class DashboardPage3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SessionBloc _sessionBlock = BlocProvider.of<SessionBloc>(context);

    return Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            child: FlatButton(
                onPressed: () {
                  _sessionBlock.emitEvent(SessionLogout());
                },
                child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.instance.text('login_out'),
                      textAlign: TextAlign.left,
                    ))
            ))
      ],
    );
  }
}