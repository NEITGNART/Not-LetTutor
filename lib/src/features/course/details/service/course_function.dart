import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../constants/constants.dart';
import '../../discover/model/course.dart';
import 'package:http/http.dart' as http;

class CourseFunction {
  static Future<Course?> getCourseById(String courseId) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');
    var url = Uri.https(apiUrl, 'course/$courseId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final course = Course.fromJson(json.decode(response.body)['data']);
      return course;
    } else {
      return null;
    }
  }
}
