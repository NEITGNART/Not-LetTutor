import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../common/constants.dart';
import '../model/Ebook.dart';
import '../model/course.dart';
import '../model/course_category.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

class CourseFunctions {
  static Future<List<Course>?> getListCourseWithPagination({
    String q = "",
    String categoryId = "",
    String orderBy = "DESC",
    List<String> levels = const [],
  }) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    final Map<String, dynamic> queryParameters = {
      'page': '1',
      'size': '100',
      // 'orderBy[]': 'ASC',
      'order[]': 'level',
    };

    if (q.isNotEmpty) {
      queryParameters.addAll({'q': q});
    }

    if (categoryId.isNotEmpty) {
      queryParameters.addAll({'categoryId[]': categoryId});
    }

    if (orderBy.isNotEmpty) {
      queryParameters.addAll({'orderBy[]': orderBy});
    }

    if (levels.isNotEmpty) {
      queryParameters.addAll({'level[]': levels});
    }

    var url = Uri.https(apiUrl, 'course', queryParameters);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res['data']['rows'] as List;
      final arr = courses.map((e) => Course.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }

  static Future<List<CourseCategory>?> getAllCourseCategories() async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'content-category');

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    //

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res['rows'] as List;
      final arr = courses.map((e) => CourseCategory.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }

  static getCourseById(String courseId) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'course/$courseId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final course = Course.fromJson(res['data']);
      return course;
    } else {
      return null;
    }
  }
}

class EbookFunctions {
  static Future<List<Ebook>?> getListEbookWithPagination(
    int page,
    int size, {
    String q = '',
    String categoryId = '',
  }) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    final queryParameters = {
      'page': '$page',
      'size': '$size',
    };

    if (q.isNotEmpty) {
      queryParameters.addAll({'q': q});
    }

    if (categoryId.isNotEmpty) {
      queryParameters.addAll({'categoryId[]': categoryId});
    }

    var url = Uri.https(apiUrl, 'e-book', queryParameters);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final ebooks = res['data']['rows'] as List;
      final arr = ebooks.map((e) => Ebook.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }
}
