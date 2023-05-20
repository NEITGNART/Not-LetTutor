// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants.dart';
import '../model/booking_info.dart';
import '../model/schedule.dart';

class BookingResponse {
  String? message;
  bool? success;
  BookingResponse({
    this.message,
    this.success,
  });
  @override
  String toString() => 'BookingReponse(message: $message, success: $success)';
}

class ScheduleFunctions {
  static int count = 0;
  static Future<List<Schedule>?> getScheduleByTutorId(String tutorId) async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'schedule');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'tutorId': tutorId,
          }));

      if (response.statusCode == 200) {
        var schedule = jsonDecode(response.body)['data'] as List;
        return schedule.map((schedule) => Schedule.fromJson(schedule)).toList();
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<BookingResponse> bookAClass(String scheduleDetailIds) async {
    final BookingResponse booking = BookingResponse();
    try {
      final List<String> list = [scheduleDetailIds];

      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'booking');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(
          {"scheduleDetailIds": list, "note": ""},
        ),
      );

      final obj = jsonDecode(response.body);
      booking.message = obj['message'];

      if (response.statusCode == 200) {
        booking.success = true;
      } else {
        booking.success = false;
      }
    } on Error catch (_) {
      booking.success = false;
      throw Exception('Failed to book a class');
    }
    return booking;
  }

  static Future<bool> cancelClass(String scheduleDetailIds) async {
    try {
      final List<String> list = [scheduleDetailIds];

      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      var url = Uri.https(apiUrl, 'booking');
      var response = await http.delete(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            "scheduleDetailIds": list,
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Error catch (_) {
      return false;
    }
  }

  static Future<List<BookingInfo>?> getUpcomingClass(
      int page, int perPage) async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');

      final current = DateTime.now().millisecondsSinceEpoch;
      final queryParameters = {
        'perPage': '$perPage',
        'page': '$page',
        'dateTimeGte': '$current',
        'orderBy': 'meeting',
        'sortBy': 'asc',
      };
      var url = Uri.https(apiUrl, 'booking/list/student', queryParameters);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final upcomingList = json.decode(response.body)['data']['rows'] as List;
        count = json.decode(response.body)['data']['count'] as int;
        final res = upcomingList.map((schedule) {
          return BookingInfo.fromJson(schedule);
        }).toList();
        return res;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<List<BookingInfo>?> getBookedClass(
      int page, int perPage) async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');

      final current = DateTime.now().millisecondsSinceEpoch;
      final queryParameters = {
        'perPage': '$perPage',
        'page': '$page',
        'dateTimeLte': current.toString(),
        'orderBy': 'meeting',
        'sortBy': 'desc',
      };
      var url = Uri.https(apiUrl, 'booking/list/student', queryParameters);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final upcomingList = json.decode(response.body)['data']['rows'] as List;
        final res = upcomingList
            .map((schedule) => BookingInfo.fromJson(schedule))
            .toList();
        return res;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static getTotalHourLesson() async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');

      var url = Uri.https(apiUrl, 'call/total');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      return json.decode(response.body)['total'];
    } on Error catch (_) {
      return 0;
    }
  }

  static getNextClass() async {
    try {
      var storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'accessToken');
      final current = DateTime.now().millisecondsSinceEpoch;
      final queryParameters = {'dateTime': '$current'};

      var url = Uri.https(apiUrl, 'booking/next', queryParameters);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        List<BookingInfo> lessonList =
            data.map((e) => BookingInfo.fromJson(e)).toList();
        lessonList.sort((a, b) => a.scheduleDetailInfo!.startPeriodTimestamp
            .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp));
        lessonList = lessonList
            .where((element) =>
                element.scheduleDetailInfo!.startPeriodTimestamp > current)
            .toList();
        if (lessonList.isEmpty) {
          return null;
        } else {
          return lessonList.first;
        }
      }
    } on Error catch (_) {
      return null;
    }
  }
}
