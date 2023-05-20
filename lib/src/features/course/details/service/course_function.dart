import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../common/constants.dart';
import '../../discover/model/course.dart';
import 'package:http/http.dart' as http;

/**
 * 
 * {
    "message": "Success",
    "data": {
        "id": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
        "name": "IELTS Speaking Part 1",
        "description": "Practice answering Part 1 questions from past years' IELTS exams",
        "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b9a72db0da5490226b6b5?h=d41d8cd98f00b204e9800998ecf8427e",
        "level": "0",
        "reason": "Feeling confident answering Part 1 questions will help you get off to a strong start on your IELTS speaking exam.",
        "purpose": "You'll practice giving strong answers in Part 1, with tips and tricks recommended by real IELTS examiners. ",
        "other_details": "",
        "default_price": 0,
        "course_price": 0,
        "courseType": null,
        "sectionType": null,
        "visible": true,
        "displayOrder": null,
        "createdAt": "2021-09-03T05:10:27.633Z",
        "updatedAt": "2021-09-03T05:10:27.633Z",
        "topics": [
            {
                "id": "c2b2b3b5-4695-496f-bef8-f5f35a8b3a81",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 0,
                "name": "Holidays and Vacations",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileHolidays and Vacations.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:10:52.872Z",
                "updatedAt": "2021-09-03T05:10:52.872Z"
            },
            {
                "id": "e3551b5b-7b71-42db-b8a7-fb65d84dd253",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 1,
                "name": "Art",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileArt.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:10:55.821Z",
                "updatedAt": "2021-09-03T05:10:55.821Z"
            },
            {
                "id": "fd664c57-334d-4ccd-80e8-8564056a19b7",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 2,
                "name": "Education",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileEducation.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:10:58.820Z",
                "updatedAt": "2021-09-03T05:10:58.820Z"
            },
            {
                "id": "c253274b-db89-4cb3-8e97-1d1a529086d5",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 3,
                "name": "News and Media",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileNews and Media.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:11:01.964Z",
                "updatedAt": "2021-09-03T05:11:01.964Z"
            },
            {
                "id": "b6c95879-ec87-4aac-bc8c-ffb8efff92ba",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 4,
                "name": "Nature and Environment",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileNature and Environment.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:11:04.965Z",
                "updatedAt": "2021-09-03T05:11:04.965Z"
            },
            {
                "id": "1e9df40a-66fd-4208-a814-f38fbe56dbf8",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 5,
                "name": "Friends",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFriends.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:11:07.965Z",
                "updatedAt": "2021-09-03T05:11:07.965Z"
            },
            {
                "id": "f906ff92-12d5-4fbe-b5f8-f714d1cd51f0",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 6,
                "name": "Food and Restaurants",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFood and Restaurants.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:11:10.972Z",
                "updatedAt": "2021-09-03T05:11:10.972Z"
            },
            {
                "id": "57a52680-4874-4eba-9e4e-3bbe91ad32ac",
                "courseId": "88d8bc4c-3ed2-4c70-b64b-61fff7461712",
                "orderCourse": 7,
                "name": "Technology",
                "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileTechnology.pdf",
                "numberOfPages": null,
                "description": "",
                "videoUrl": null,
                "type": null,
                "createdAt": "2021-09-03T05:11:13.961Z",
                "updatedAt": "2021-09-03T05:11:13.961Z"
            }
        ],
        "users": []
    }
}
 */
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
