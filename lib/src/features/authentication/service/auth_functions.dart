// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants.dart';
import '../data/model/http_response.dart';
import '../data/model/login_response.dart';
import '../data/model/user.dart';
import '../data/model/user_auth.dart';

class ForgotPasswordResponse {
  int? statusCode;
  String? message;

  ForgotPasswordResponse({this.statusCode, this.message});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}

class AuthFunctions {
  static Future<Map<String, Object>> refreshAuth(
      String refreshToken, cb) async {
    try {
      var url = Uri.https(apiUrl, 'auth/refresh-token');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'refreshToken': refreshToken,
            'timezone': 7,
          }));

      if (response.statusCode == 200) {
        var storage = const FlutterSecureStorage();
        String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
        AuthUser authUser = AuthUser.fromJson(jsonDecode(response.body));
        await storage.write(key: 'accessToken', value: token);
        cb(authUser);
        return {
          'isSuccess': true,
          'token': token,
        };
      } else {
        return {
          'isSuccess': false,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<ForgotPasswordResponse?> forgetPassword(String email) async {
    try {
      var url = Uri.https(apiUrl, 'user/forgotPassword');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': email,
          },
        ),
      );
      return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
    } on Error catch (_) {
      return null;
    }
  }

  static Future<Map<String, Object>> register(User user) async {
    try {
      var url = Uri.https(apiUrl, 'auth/register');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
            'source': null
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var storage = const FlutterSecureStorage();
        String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
        await storage.write(key: 'accessToken', value: token);
        return {
          'isSuccess': true,
          'message':
              'Register successfully, check your email to activate your account'
        };
      } else {
        return {
          'isSuccess': false,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<Map<String, Object>> login(User user, cb) async {
    try {
      var url = Uri.https(apiUrl, 'auth/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
          }));

      if (response.statusCode == 200) {
        var storage = const FlutterSecureStorage();
        String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
        AuthUser authUser = AuthUser.fromJson(jsonDecode(response.body));
        await storage.write(key: 'accessToken', value: token);
        cb(authUser);
        return {
          'isSuccess': true,
          'token': token,
        };
      } else {
        return {
          'isSuccess': false,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<Map<String, Object>> loginWithGoogle(
      String accessToken, cb) async {
    var url = Uri.https(apiUrl, 'auth/google');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'access_token': accessToken}));

    if (response.statusCode == 200) {
      var storage = const FlutterSecureStorage();
      String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
      AuthUser authUser = AuthUser.fromJson(jsonDecode(response.body));
      cb(authUser);
      await storage.write(key: 'accessToken', value: token);
      return {
        'isSuccess': true,
        'token': token,
      };
    } else {
      return {
        'isSuccess': false,
        'message': HttpResponse.fromJson(jsonDecode(response.body)).message
      };
    }
  }

  static Future<Map<String, Object>> loginWithFacebook(
      String accessToken, cb) async {
    var url = Uri.https(apiUrl, 'auth/facebook');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'access_token': accessToken}));

    if (response.statusCode == 200) {
      var storage = const FlutterSecureStorage();
      String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
      AuthUser authUser = AuthUser.fromJson(jsonDecode(response.body));
      await storage.write(key: 'accessToken', value: token);
      cb(authUser);
      return {
        'isSuccess': true,
        'token': token,
      };
    } else {
      return {
        'isSuccess': false,
        'message': HttpResponse.fromJson(jsonDecode(response.body)).message
      };
    }
  }
}
