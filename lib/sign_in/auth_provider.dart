import 'dart:io';
import 'package:bugrani2/services/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:bugrani2/sign_in/user.dart';
import 'package:bugrani2/sign_in/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  User? user;

  Future<Map<String, String>> signup({
    required String name,
    required String email,
    required String password,
    required String role,
    String? location,
    String? title,
  }) async {
    var response = await AuthServices().signupAPI(
      user: User(
        name: name,
        email: email,
        password: password,
        role: role,
        location: location,
        title: title,
      ),
    );
    if (response['token'] != null) {
      _setToken(email, response['token']!);
    }
    print(response['token'] ?? 'No token');
    notifyListeners();
    return response;
  }

  Future<String> signin(
      {required String email, required String password}) async {
    token = await AuthServices().loginApi(
      user: User(
        name: '',
        email: email,
        password: password,
        role: '',
      ),
    );
    _setToken(email, token!);
    user = User(name: '', email: email, password: token!, role: '');
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
      user = User(name: '', email: user!.email, password: token!, role: '');
      print('Bearer $token');
      notifyListeners();
    }
  }

  void _setToken(String email, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("token", token);
    notifyListeners();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    token = prefs.getString("token");

    if (email == null || token == null) return;

    user = User(name: '', email: email, password: token!, role: '');
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('token');
    user = null;
    notifyListeners();
  }
}
