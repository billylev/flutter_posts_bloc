import 'dart:convert';

import 'package:flutter_posts_bloc/api/web_client.dart';
import 'package:flutter_posts_bloc/models/session.dart';

class AuthApi {
  final WebClient webClient;

  const AuthApi({
    this.webClient = const WebClient(),
  });

  // calls the login api
  Future<Session> login(String username, String password) async {

    final credentials = {
      'username': username,
      'password': password,
      'grant_type': 'password'
    };

    final sessionMap = await webClient.post('token', json.encode(credentials));
    return Session.fromJson(sessionMap);
  }

  // just for demo purposes, doesnt call a real api. Use login above to do that
  Future<Session> loginEnum(String username, String password) async {

    final body = """
      {
        "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1laWQiOiJqb2huQGV4YW1wbGUuY29tIiwicm9sZSI6IlVzZXIiLCJEcml2ZXJJZCI6IkRyaXZlcjIiLCJWZWhpY2xlSWQiOiJWZWhpY2xlMiIsIkRldmljZUlkIjoiRGV2aWNlMiIsImlzcyI6Imh0dHBzOi8vY29ubmVjdGVkY2FyLmF6dXJld2Vic2l0ZXMubmV0IiwiYXVkIjoiaHR0cHM6Ly9jb25uZWN0ZWRjYXIuYXp1cmV3ZWJzaXRlcy5uZXQiLCJleHAiOjIwOTk5ODgxODAsIm5iZiI6MTQ2ODIzMTQzMH0.03B5fxkq22lyvj91JNJyr0_ZKLyJ57THM4C6L6w5nj4",
        "token_type": "Bearer",
        "refresh_token": "wefioewfwefI#OIFEWNFIOWEFNWEFewfiewofnewoi23432842398423789423{}",
        "expires_in": 123123123
      }""";

    // wait to simulate web call
    await Future.delayed(Duration(seconds: 2));

    final sessionMap = json.decode(body);

    return Session.fromJson(sessionMap);
  }
}

