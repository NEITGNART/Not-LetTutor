// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/hive_flutter.dart';

class LoginResponse {
  final String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['tokens']['access']['token'],
    );
  }
}
