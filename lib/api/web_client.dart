import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;


class WebClient {

  // todo replace with your local ip
  final String serverAddress = "http://192.168.2.96:1080/";

  const WebClient();

  Future<dynamic> get(String path) async {
    final http.Response response = await http.Client().get(
      serverAddress + path,
        );

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    return json.decode(response.body);
  }

  Future<dynamic> post(String path, dynamic data) async {
    final http.Response response = await http.Client().post(
      serverAddress + path,
      body: data,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    try {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
  }

  Future<dynamic> put(String path, dynamic data) async {
    final http.Response response = await http.Client().put(
      serverAddress + path,
      body: data,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    try {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
  }
}
