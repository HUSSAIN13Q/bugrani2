import 'dart:io';

import 'package:bugrani2/services/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:bugrani2/sign_in/user.dart';
import 'package:bugrani2/sign_in/auth_services.dart';
class AuthProvider extends ChangeNotifier {
  String? token; //"error", "email", "token"
  User? user;

  Future<Map<String, String>> signup(
      {required String username, required String password}) async {
    var response = await AuthServices()
        .signupAPI(user: User(username: username, token: password));
    if (response['token'] != null) {
      _setToken(username, response['token']!);
    }
    print(response['token'] ?? 'No token');
    notifyListeners();
    return response;
  }

  Future<String> signin(
      {required String username, required String password}) async {
    token = await AuthServices()
        .loginApi(user: User(username: username, token: password));
    // this.user = user;
    _setToken(username, token!);
    // print(token);
    user = User(username: username, token: token!);
    notifyListeners();
    return token!;
  }

  bool isAuth() {
    return (user != null && token!.isNotEmpty);
  }

  Future<void> initAuth() async {
    await getToken();
    if (isAuth()) {
      dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      user = User(username: user!.username, token: token!);
      print('Bearer $token');
      notifyListeners();
    }
  }

  void _setToken(String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("token", token);
    notifyListeners();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    token = prefs.getString("token");

    if (username == null || token == null) return;

    user = User(username: username, token: token!);
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('token');
    user = null;
    notifyListeners();
  }
}
