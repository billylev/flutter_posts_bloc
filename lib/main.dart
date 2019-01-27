import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_posts_bloc/bloc_helpers/bloc_state_builder.dart';
import 'package:flutter_posts_bloc/blocs/session/session_bloc.dart';
import 'package:flutter_posts_bloc/blocs/session/session_event.dart';
import 'package:flutter_posts_bloc/blocs/session/session_state.dart';
import 'package:flutter_posts_bloc/localizations.dart';
import 'package:flutter_posts_bloc/ui/dashboard/dashboard.dart';
import 'package:flutter_posts_bloc/ui/login.dart';
import 'package:flutter_posts_bloc/ui/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final SessionBloc _sessionBloc = SessionBloc();

  @override
  void initState() {
    super.initState();
    _sessionBloc.emitEvent(SessionStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionBloc>(
        bloc: _sessionBloc,
        child: MaterialApp(
            theme: new ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('es', ''),
            ],
            localeResolutionCallback:
                (Locale locale, Iterable<Locale> supportedLocales) {
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            home: BlocEventStateBuilder<SessionState>(
                bloc: _sessionBloc,
                builder: (BuildContext context, SessionState state) {
                  if (state is SessionUninitialized) {
                    return SplashScreen();
                  }

                  if (state is SessionUnAuthenticated) {
                    return LoginScreen();
                  }

                  if (state is SessionAuthenticated) {
                    return DashboardScreen();
                  }
                })));
  }

  @override
  void dispose() {
    _sessionBloc.dispose();
    super.dispose();
  }
}
