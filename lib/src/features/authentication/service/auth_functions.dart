import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../common/constants.dart';
import '../data/model/http_response.dart';
import '../data/model/login_response.dart';
import '../data/model/user.dart';
import '../data/model/user_auth.dart';

class AuthFunctions {
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
      Logger().e(error.toString());
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<Map<String, Object>> loginWithGoogle(String accessToken) async {
    var url = Uri.https(apiUrl, 'auth/google');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'access_token': accessToken}));

    if (response.statusCode == 200) {
      var storage = const FlutterSecureStorage();
      String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
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
      String accessToken) async {
    var url = Uri.https(apiUrl, 'auth/facebook');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'access_token': accessToken}));

    if (response.statusCode == 200) {
      var storage = const FlutterSecureStorage();
      String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
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
}
