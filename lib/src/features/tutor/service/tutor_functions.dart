// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:beatiful_ui/src/features/tutor/model/tutor_search.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../common/constants.dart';
import '../model/filter_tutor.dart';
import '../model/tutor.dart';
import '../model/tutor_review.dart';

class MyPage {
  int page;
  int perPage;
  MyPage({this.page = 1, this.perPage = 12});
}

class TutorFunctions {
  static int reviewCount = 0;

  static Future<List<TutorInfoSearch>?> getTutorList(
      SearchFilter filters) async {
    List<TutorInfoSearch> tutorList = <TutorInfoSearch>[];
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'tutor/search');

      final body = {
        "filters": {
          "specialties": filters.filters?.specialties ?? [],
          "date": null,
          "tutoringTimeAvailable": [null, null],
          "nationality": filters.filters!.nationality!,
        },
        "page": filters.page,
        "perPage": filters.perPage,
      };
      if (filters.search != null && filters.search!.isNotEmpty) {
        body['search'] = filters.search!;
      }

      // if (filters.filters?.nationality != null) {
      //   Logger().i(filters.filters!.nationality!);
      //   body['filters']!['nationality'] = filters.filters!.nationality!;
      // }

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        var tutorArray = jsonDecode(response.body)['rows'];
        for (var tutor in tutorArray) {
          tutorList.add(TutorInfoSearch.fromJson(tutor));
        }
        return tutorList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  // static Future<List<Tutor>?> getTutorList(int page, int perPage) async {
  //   List<Tutor> tutorList = <Tutor>[];
  //   try {
  //     var storage = const FlutterSecureStorage();
  //     String? token = await storage.read(key: 'accessToken');
  //     final queryParameters = {
  //       'perPage': '$perPage',
  //       'page': '$page',
  //     };
  //     var url = Uri.https(apiUrl, 'tutor/more', queryParameters);
  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       var tutorArray = jsonDecode(response.body)['tutors']['rows'];
  //       for (var tutor in tutorArray) {
  //         tutorList.add(Tutor.fromJson(tutor));
  //       }
  //       return tutorList;
  //     } else {
  //       return null;
  //     }
  //   } on Error catch (_) {
  //     return null;
  //   }
  // }

  static Future<Tutor?> getTutorInfomation(String id) async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'tutor/$id');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return Tutor.fromJson2(jsonDecode(response.body));
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<List<TutorReview>?> getTutorReview(
    String id,
    MyPage page,
  ) async {
    final reviews = <TutorReview>[];
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'feedback/v2/$id', {
        'page': '${page.page}',
        'perPage': '${page.perPage}',
      });
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        // return TutorReview.fromJson(jsonDecode(response.body)["data"]["rows"])
        var reviewsJson = jsonDecode(response.body)['data']['rows'];
        reviewCount = jsonDecode(response.body)['data']['count'] as int;
        for (var review in reviewsJson) {
          reviews.add(TutorReview.fromJson(review));
        }
        return reviews;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<bool> reportTutor(String id, String content) async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'report');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({'tutorId': id, 'content': content}));
      if (response.statusCode == 200) {
        return true;
      } else {
        Logger().e(response.body);
        return false;
      }
    } on Error catch (_) {
      Logger().e(_.toString());
      return false;
    }
  }

  static Future<bool> manageFavoriteTutor(String id) async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'user/manageFavoriteTutor');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'tutorId': id,
          }));

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['result'] == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on Error catch (_) {
      return false;
    }
  }

  static Future<List<Tutor>> searchTutor(
    int page,
    int perPage, {
    String search = '',
  }) async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      final Map<String, dynamic> args = {
        'page': page,
        'perPage': perPage,
        'search': search,
      };

      final url = Uri.https(apiUrl, 'tutor/search');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(args),
      );

      if (response.statusCode == 200) {
        final jsonRes = json.decode(response.body);
        final List<dynamic> tutors = jsonRes["rows"];
        return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
      } else {
        return [];
      }
    } on Error catch (_) {
      return [];
    }
  }
}
