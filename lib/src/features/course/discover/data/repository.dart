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

const String temporaryToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmNTY5YzIwMi03YmJmLTQ2MjAtYWY3Ny1lY2MxNDE5YTZiMjgiLCJpYXQiOjE2Nzg4ODk3NzQsImV4cCI6MTY3ODk3NjE3NCwidHlwZSI6ImFjY2VzcyJ9.GMHJDnCLKWcnE5aEBDtaaq-E9Xd_UriHUA3payZ8-lo";

abstract class CourseRepository {
  Future<List<Course>?> getListCourseWithPagination(
    int page,
    int size, {
    String q = "",
    String categoryId = "",
  });
}

const String courseJsonString = """

{
    "message": "Success",
    "data": {
        "count": 24,
        "rows": [
            {
                "id": "964bed84-6450-49ee-92d5-e8c565864bd9",
                "name": "Life in the Internet Age",
                "description": "Let's discuss how technology is changing the way we live",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "4",
                "reason": "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
                "purpose": "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T04:35:27.434Z",
                "updatedAt": "2021-09-03T04:35:27.434Z",
                "topics": [
                    {
                        "id": "1e733088-07ae-464c-8cd1-99b450c7a83b",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 2,
                        "name": "Social Media",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSocial Media.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:35:55.208Z",
                        "updatedAt": "2021-09-03T04:35:55.208Z"
                    },
                    {
                        "id": "d1f1fdcf-281f-445a-afea-c0cb9ca695d2",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 3,
                        "name": "Internet Privacy",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileInternet Privacy.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:36:11.205Z",
                        "updatedAt": "2021-09-03T04:36:11.205Z"
                    },
                    {
                        "id": "54d226f0-430c-426a-8e4a-cd5ebf86f8b3",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 4,
                        "name": "Live Streaming",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileLive Streaming.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:36:23.565Z",
                        "updatedAt": "2021-09-03T04:36:23.565Z"
                    },
                    {
                        "id": "5eb6e96b-c207-404f-a601-ab6703f84d5d",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 5,
                        "name": "Coding",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCoding.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:36:39.383Z",
                        "updatedAt": "2021-09-03T04:36:39.383Z"
                    },
                    {
                        "id": "bd3023c3-5fdd-4f36-acde-87a270830730",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 0,
                        "name": "The Internet",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileThe Internet.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:35:50.484Z",
                        "updatedAt": "2021-09-03T04:35:50.484Z"
                    },
                    {
                        "id": "e852662e-fb14-4ecd-99fb-6f265436c720",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 6,
                        "name": "Technology Transforming Healthcare",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileTechnology Transforming Healthcare.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:36:53.076Z",
                        "updatedAt": "2021-09-03T04:36:53.076Z"
                    },
                    {
                        "id": "3bbb39c7-90bd-46cf-8a9d-f709327ea13d",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 8,
                        "name": "Remote Work - A Dream Job?",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileRemote Work - A Dream Job.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:37:23.268Z",
                        "updatedAt": "2021-09-03T04:37:23.268Z"
                    },
                    {
                        "id": "36c9bcbf-3b52-4995-9d15-570b546f0037",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 7,
                        "name": "Smart Home Technology",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSmart Home Technology.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:37:07.700Z",
                        "updatedAt": "2021-09-03T04:37:07.700Z"
                    },
                    {
                        "id": "8946bc98-8d19-42d6-8af2-0d62cca0d495",
                        "courseId": "964bed84-6450-49ee-92d5-e8c565864bd9",
                        "orderCourse": 1,
                        "name": "Artificial Intelligence (AI)",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileArtificial Intelligence (AI).pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:35:52.935Z",
                        "updatedAt": "2021-09-03T04:35:52.935Z"
                    }
                ],
                "categories": [
                    {
                        "id": "d95b69f7-b810-4cdf-b11d-49faaa71ff4b",
                        "title": "English for Traveling",
                        "description": null,
                        "key": "TRAVEL",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "46972669-1755-4f27-8a87-dc4dd2630492",
                "name": "Basic Conversation Topics",
                "description": "Gain confidence speaking about familiar topics",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "1",
                "reason": "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.",
                "purpose": "This course covers vocabulary at the CEFR A2 level. You will build confidence while learning to speak about a variety of common, everyday topics. In addition, you will build implicit grammar knowledge as your tutor models correct answers and corrects your mistakes.",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T04:40:27.647Z",
                "updatedAt": "2021-09-03T04:40:27.647Z",
                "topics": [
                    {
                        "id": "c8b789ed-9bc7-474a-8b7d-744cd1783a6d",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 1,
                        "name": "Your Job",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour Job.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:41:06.415Z",
                        "updatedAt": "2021-09-03T04:41:06.415Z"
                    },
                    {
                        "id": "27231310-92cc-4890-8ed0-0ebc46f9ff72",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 2,
                        "name": "Playing and Watching Sports",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afilePlaying and Watching Sports.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:41:20.216Z",
                        "updatedAt": "2021-09-03T04:41:20.216Z"
                    },
                    {
                        "id": "a897682f-e8ea-46cb-90dd-ce7bf68aedd4",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 3,
                        "name": "The Best Pet",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileThe Best Pet.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:41:35.675Z",
                        "updatedAt": "2021-09-03T04:41:35.675Z"
                    },
                    {
                        "id": "effda3d9-32ac-495c-a458-0b733fc48281",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 4,
                        "name": "Having Fun in Your Free Time",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileHaving Fun in Your Free Time.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:41:49.685Z",
                        "updatedAt": "2021-09-03T04:41:49.685Z"
                    },
                    {
                        "id": "241cf600-2397-4390-921a-9b6419db5e97",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 5,
                        "name": "Your Daily Routine",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour Daily Routine.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:42:05.263Z",
                        "updatedAt": "2021-09-03T04:42:05.263Z"
                    },
                    {
                        "id": "3edacb8b-8efa-4a2e-93a3-fe3f9cd6e2f8",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 6,
                        "name": "Childhood Memories",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileChildhood Memories.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:42:21.748Z",
                        "updatedAt": "2021-09-03T04:42:21.748Z"
                    },
                    {
                        "id": "806dc1ce-e060-48b1-91a8-ac3bc55312ff",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 7,
                        "name": "Your Family Members",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour Family Members.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:42:33.550Z",
                        "updatedAt": "2021-09-03T04:42:33.550Z"
                    },
                    {
                        "id": "2baed145-430c-4b4e-8aea-07fe3e3afbbb",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 8,
                        "name": "Your Hometown",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour Hometown.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:42:50.007Z",
                        "updatedAt": "2021-09-03T04:42:50.007Z"
                    },
                    {
                        "id": "db156def-9c2e-4df2-a4d9-bd0d30c41f5f",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 9,
                        "name": "Shopping Habits",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileShopping Habits.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:43:05.649Z",
                        "updatedAt": "2021-09-03T04:43:05.649Z"
                    },
                    {
                        "id": "2bf48214-b53f-4f90-8459-e7f3e63c79f5",
                        "courseId": "46972669-1755-4f27-8a87-dc4dd2630492",
                        "orderCourse": 0,
                        "name": "Foods You Love",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFoods You Love.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:41:03.252Z",
                        "updatedAt": "2021-09-03T04:41:03.252Z"
                    }
                ],
                "categories": [
                    {
                        "id": "488cc5f8-a5b1-45cd-8d3a-47e690f9298e",
                        "title": "English for Beginners",
                        "description": null,
                        "key": "BEGINNER",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                "name": "Intermediate Conversation Topics",
                "description": "Express your ideas and opinions",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b99d0c4288f294426b643?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "4",
                "reason": "Looking for some variety in your lesson topics? Immerse yourself in English discussion with this set of engaging topics.",
                "purpose": "This course covers vocabulary at the CEFR B1-B2 levels. You will work on improving fluency and comprehension by discussing a variety of topics. In addition, you will receive corrections from a native English speaker to help improve your grammatical accuracy.",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T04:45:27.609Z",
                "updatedAt": "2021-09-03T04:45:27.609Z",
                "topics": [
                    {
                        "id": "01753d46-1d4d-4f80-8e66-081a3b990a43",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 1,
                        "name": "Your Dream Job",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour Dream Job.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:46:06.474Z",
                        "updatedAt": "2021-09-03T04:46:06.474Z"
                    },
                    {
                        "id": "e8a8a87d-a30d-4923-be16-3b312c97aa21",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 2,
                        "name": "Sports Fitness",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSports Fitness.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:46:15.929Z",
                        "updatedAt": "2021-09-03T04:46:15.929Z"
                    },
                    {
                        "id": "4e7e63fb-dbb5-41a7-a738-5f44f21125d2",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 3,
                        "name": "Service Animals",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileService Animals.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:46:29.010Z",
                        "updatedAt": "2021-09-03T04:46:29.010Z"
                    },
                    {
                        "id": "74e61270-530b-48bf-9fec-1d0b39017348",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 4,
                        "name": "Social Activities",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSocial Activities.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:46:38.365Z",
                        "updatedAt": "2021-09-03T04:46:38.365Z"
                    },
                    {
                        "id": "dc89e219-2240-4ae2-a79c-45bf8c95b6bc",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 5,
                        "name": "Your Ideal Day",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour Ideal Day.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:46:53.295Z",
                        "updatedAt": "2021-09-03T04:46:53.295Z"
                    },
                    {
                        "id": "7de132f2-417e-4b8f-9387-0b5db3f958c5",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 6,
                        "name": "Childhood Friendships",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileChildhood Friendships.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:47:03.346Z",
                        "updatedAt": "2021-09-03T04:47:03.346Z"
                    },
                    {
                        "id": "e6261895-2f0c-4fce-b1f9-2288c2f4ce33",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 7,
                        "name": "The Importance of Family",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileThe Importance of Family.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:47:18.237Z",
                        "updatedAt": "2021-09-03T04:47:18.237Z"
                    },
                    {
                        "id": "456b6b1c-baf8-4eb1-980d-470d0954a17a",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 8,
                        "name": "City Life",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCity Life.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:47:29.699Z",
                        "updatedAt": "2021-09-03T04:47:29.699Z"
                    },
                    {
                        "id": "c311cff4-a8ae-43de-9e19-4e560bb04b70",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 9,
                        "name": "Online Shopping",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileOnline Shopping.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:47:41.670Z",
                        "updatedAt": "2021-09-03T04:47:41.670Z"
                    },
                    {
                        "id": "8cb9312a-1e32-4f46-8326-c92962417bdf",
                        "courseId": "5ff5562b-8744-4cf1-a242-5abda43e3ab9",
                        "orderCourse": 0,
                        "name": "Cooking",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCooking.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:45:56.933Z",
                        "updatedAt": "2021-09-03T04:45:56.933Z"
                    }
                ],
                "categories": [
                    {
                        "id": "488cc5f8-a5b1-45cd-8d3a-47e690f9298e",
                        "title": "English for Beginners",
                        "description": null,
                        "key": "BEGINNER",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                "name": "Advanced Conversation Topics",
                "description": "Explore complex topics relevant to modern life",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b99e60b114e9a327ceb66?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "7",
                "reason": "Challenge yourself with new topics to expand you vocabulary and increase your comfort with the English language.",
                "purpose": "This course covers vocabulary at the CEFR C1-C2 levels. You will work on gaining fluency by speaking at length about a wide array of topics. In addition, you will receive corrections from a native English speaker to help improve coherence and grammatical accuracy.",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T04:50:27.620Z",
                "updatedAt": "2021-09-03T04:50:27.620Z",
                "topics": [
                    {
                        "id": "43a17397-1555-4e0d-adc9-ff7394e36ddd",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 1,
                        "name": "Developing Your Career",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileDeveloping Your Career.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:51:05.579Z",
                        "updatedAt": "2021-09-03T04:51:05.579Z"
                    },
                    {
                        "id": "7a0de151-5bb9-43d9-a4c6-c08985c034c3",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 2,
                        "name": "Sports Fanaticism",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSports Fanaticism.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:51:18.650Z",
                        "updatedAt": "2021-09-03T04:51:18.650Z"
                    },
                    {
                        "id": "cc96dd39-95dc-440b-a27d-98f5cb4dc28c",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 3,
                        "name": "Exotic Pets",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileExotic Pets.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:51:28.591Z",
                        "updatedAt": "2021-09-03T04:51:28.591Z"
                    },
                    {
                        "id": "db2bc079-3acc-4ef5-a136-8a799bfb8afc",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 4,
                        "name": "Work-Life Balance",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileWork-Life Balance.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:51:39.395Z",
                        "updatedAt": "2021-09-03T04:51:39.395Z"
                    },
                    {
                        "id": "2cf807e8-89c4-4674-bb7a-899790bcaf2b",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 5,
                        "name": "Living Your Best Life",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileLiving Your Best Life.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:51:52.175Z",
                        "updatedAt": "2021-09-03T04:51:52.175Z"
                    },
                    {
                        "id": "2e5e328a-645e-4d84-a2f5-db2b7edb1634",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 6,
                        "name": "Raising Children",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileRaising Children.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:52:03.951Z",
                        "updatedAt": "2021-09-03T04:52:03.951Z"
                    },
                    {
                        "id": "af81f399-c454-48b1-a085-5160e4d35c0b",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 7,
                        "name": "Family Dynamics",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFamily Dynamics.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:52:17.780Z",
                        "updatedAt": "2021-09-03T04:52:17.780Z"
                    },
                    {
                        "id": "32977fb9-bb42-46ad-8085-47e99df0d1e1",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 8,
                        "name": "Community Service",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCommunity Service.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:52:29.817Z",
                        "updatedAt": "2021-09-03T04:52:29.817Z"
                    },
                    {
                        "id": "2b1fd6f6-dc93-4bcb-b36b-6a1d7f9a502e",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 9,
                        "name": "Consumerism",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileConsumerism.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:52:39.561Z",
                        "updatedAt": "2021-09-03T04:52:39.561Z"
                    },
                    {
                        "id": "c36aa863-81a6-4c30-b829-784e44527cab",
                        "courseId": "82873d99-da2b-4dc6-83b1-2d97890909cf",
                        "orderCourse": 0,
                        "name": "Food for Thought",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFood for Thought.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:50:55.817Z",
                        "updatedAt": "2021-09-03T04:50:55.817Z"
                    }
                ],
                "categories": [
                    {
                        "id": "488cc5f8-a5b1-45cd-8d3a-47e690f9298e",
                        "title": "English for Beginners",
                        "description": null,
                        "key": "BEGINNER",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                "name": "Caring for Our Planet",
                "description": "Let's discuss our relationship as humans with our planet, Earth",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b99f70f8f1e9f625e8317?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "4",
                "reason": "As climate change and environmentalism become increasingly global issues, this topic appears often in international news and is relevant to many international industries.",
                "purpose": "This course covers intermediate level vocabulary related to sustainability and environmental science. In addition, you will complete technical tasks such as describing charts, analyzing data, and making estimations.",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T04:55:27.621Z",
                "updatedAt": "2021-09-03T04:55:27.621Z",
                "topics": [
                    {
                        "id": "a8793b12-a528-4c49-82f0-cdcbccfe552c",
                        "courseId": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                        "orderCourse": 5,
                        "name": "Engaging in Ecosystems",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileEngaging in Ecosystems.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:57:16.941Z",
                        "updatedAt": "2021-09-03T04:57:16.941Z"
                    },
                    {
                        "id": "6177465c-f123-4cc6-845f-89efbeb3b076",
                        "courseId": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                        "orderCourse": 0,
                        "name": "Recycling for Sustainability",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileRecycling for Sustainability.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:56:05.132Z",
                        "updatedAt": "2021-09-03T04:56:05.132Z"
                    },
                    {
                        "id": "35feac0d-b256-4053-84d4-f48c2f9ba320",
                        "courseId": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                        "orderCourse": 1,
                        "name": "Renewable Energy Sources",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileRenewable Energy Sources.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:56:21.608Z",
                        "updatedAt": "2021-09-03T04:56:21.608Z"
                    },
                    {
                        "id": "11c66f8e-f364-4556-89c3-d941c13f9113",
                        "courseId": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                        "orderCourse": 2,
                        "name": "Our Changing Climate",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileOur Changing Climate.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:56:34.894Z",
                        "updatedAt": "2021-09-03T04:56:34.894Z"
                    },
                    {
                        "id": "d677927b-3789-49b3-8fe2-a405a6e24025",
                        "courseId": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                        "orderCourse": 3,
                        "name": "Pollution Solutions",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afilePollution Solutions.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:56:47.674Z",
                        "updatedAt": "2021-09-03T04:56:47.674Z"
                    },
                    {
                        "id": "843f39ef-2c62-42a9-8690-0f6c938d8e6e",
                        "courseId": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                        "orderCourse": 4,
                        "name": "The Zero Waste Movement",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileThe Zero Waste Movement.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:57:05.194Z",
                        "updatedAt": "2021-09-03T04:57:05.194Z"
                    },
                    {
                        "id": "8cf5a188-5eb0-443c-af87-c8524589b895",
                        "courseId": "3476c86d-6d8c-46c9-aedd-a116a5891acb",
                        "orderCourse": 6,
                        "name": "Exotic and Endangered Animals",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileExotic and Endangered Animals.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T04:57:34.217Z",
                        "updatedAt": "2021-09-03T04:57:34.217Z"
                    }
                ],
                "categories": [
                    {
                        "id": "d95b69f7-b810-4cdf-b11d-49faaa71ff4b",
                        "title": "English for Traveling",
                        "description": null,
                        "key": "TRAVEL",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "445e1ebe-af03-444d-8dcd-162d40f778db",
                "name": "Healthy Mind, Healthy Body",
                "description": "Let's discuss the many aspects of living a long, happy life",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b9a4c05342470fdddf8b8?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "4",
                "reason": "",
                "purpose": "Discuss topics related to physical, mental, and emotional health. Learn about other cultures along the way in friendly conversations with tutors.",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T05:00:27.687Z",
                "updatedAt": "2021-09-03T05:00:27.687Z",
                "topics": [
                    {
                        "id": "4bf33d78-c204-4d9a-bf80-f0d513d1aa28",
                        "courseId": "445e1ebe-af03-444d-8dcd-162d40f778db",
                        "orderCourse": 1,
                        "name": "Working Up A Sweat",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileWorking Up A Sweat.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:01:14.913Z",
                        "updatedAt": "2021-09-03T05:01:14.913Z"
                    },
                    {
                        "id": "97f9b3b1-9ee7-4938-8750-f80ae1c4d8f3",
                        "courseId": "445e1ebe-af03-444d-8dcd-162d40f778db",
                        "orderCourse": 2,
                        "name": "Drink Up",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileDrink Up.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:01:34.256Z",
                        "updatedAt": "2021-09-03T05:01:34.256Z"
                    },
                    {
                        "id": "dcb51261-d06d-47da-8db7-e8df0538d9fa",
                        "courseId": "445e1ebe-af03-444d-8dcd-162d40f778db",
                        "orderCourse": 3,
                        "name": "Catching Some Z's",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCatching Some Z's.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:01:46.872Z",
                        "updatedAt": "2021-09-03T05:01:46.872Z"
                    },
                    {
                        "id": "e9dc8f90-0e13-4d84-bbfb-0dae90e1d2f0",
                        "courseId": "445e1ebe-af03-444d-8dcd-162d40f778db",
                        "orderCourse": 4,
                        "name": "Chill Out",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileChill Out.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:02:03.088Z",
                        "updatedAt": "2021-09-03T05:02:03.088Z"
                    },
                    {
                        "id": "50a9ab6b-7b16-4c43-a1b8-9fed19a87d33",
                        "courseId": "445e1ebe-af03-444d-8dcd-162d40f778db",
                        "orderCourse": 5,
                        "name": "Look On The Bright Side",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileLook On The Bright Side.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:02:18.123Z",
                        "updatedAt": "2021-09-03T05:02:18.123Z"
                    },
                    {
                        "id": "f146953a-4698-420f-bce0-ff3745d13400",
                        "courseId": "445e1ebe-af03-444d-8dcd-162d40f778db",
                        "orderCourse": 0,
                        "name": "You Are What You Eat",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYou Are What You Eat.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:01:02.525Z",
                        "updatedAt": "2021-09-03T05:01:02.525Z"
                    }
                ],
                "categories": [
                    {
                        "id": "d95b69f7-b810-4cdf-b11d-49faaa71ff4b",
                        "title": "English for Traveling",
                        "description": null,
                        "key": "TRAVEL",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                "name": "Business English",
                "description": "The English you need for your work and career",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b9a5feb6295be78ddf8c3?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "4",
                "reason": "Understanding business culture and customs is just as important as learning traditional business-related vocabulary. With Cambly's Business English course, you have the chance to learn from expertly-crafted lessons as well as from your tutor's personal experiences.",
                "purpose": "This course covers the most common vocabulary and grammatical structures needed to do business in English. The course focuses on simulating real-life business situations to build professional communicative competency. You will also learn idioms being used in English-speaking offices across the globe.",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T05:05:27.636Z",
                "updatedAt": "2021-09-03T05:05:27.636Z",
                "topics": [
                    {
                        "id": "028e38e5-9c38-4735-b1c1-5cf10f371e91",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 0,
                        "name": "Phone Conversations",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afilePhone Conversations.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:05:53.946Z",
                        "updatedAt": "2021-09-03T05:05:53.946Z"
                    },
                    {
                        "id": "6cb21461-46ed-48dc-b094-dd011205008e",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 2,
                        "name": "Negotiations ",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileNegotiations .pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:05:57.630Z",
                        "updatedAt": "2021-09-03T05:05:57.630Z"
                    },
                    {
                        "id": "42ed1bf2-a10f-4372-a0af-075ddc7da228",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 3,
                        "name": "Complaints and Conflicts",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileComplaints and Conflicts.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:06:00.579Z",
                        "updatedAt": "2021-09-03T05:06:00.579Z"
                    },
                    {
                        "id": "19c48938-9c69-44bc-9fa4-b5349b56aa29",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 4,
                        "name": "Job Interviews ",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileJob Interviews .pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:06:04.621Z",
                        "updatedAt": "2021-09-03T05:06:04.621Z"
                    },
                    {
                        "id": "d39482e7-707c-46e1-a658-a0f22841ca22",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 5,
                        "name": "Scheduling and Time Management",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileScheduling and Time Management.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:06:07.576Z",
                        "updatedAt": "2021-09-03T05:06:07.576Z"
                    },
                    {
                        "id": "8d8410e9-a53c-4488-b404-df9cb3e0f63f",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 6,
                        "name": "Presentations",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afilePresentations.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:06:08.369Z",
                        "updatedAt": "2021-09-03T05:06:08.369Z"
                    },
                    {
                        "id": "6de85038-c1f9-4895-85d8-1e5655c3946d",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 7,
                        "name": "Work Styles",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileWork Styles.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:06:11.093Z",
                        "updatedAt": "2021-09-03T05:06:11.093Z"
                    },
                    {
                        "id": "b18f525e-107a-40cb-bf50-e98107244d53",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 8,
                        "name": "Management and Leadership",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileManagement and Leadership.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:06:17.468Z",
                        "updatedAt": "2021-09-03T05:06:17.468Z"
                    },
                    {
                        "id": "d841bf25-accc-4916-8f6e-1bc408a5392a",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 9,
                        "name": "Sales",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSales.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:06:19.818Z",
                        "updatedAt": "2021-09-03T05:06:19.818Z"
                    },
                    {
                        "id": "35e286f2-ca6d-44a1-81d0-fd5cbaadca97",
                        "courseId": "e4c35c31-7a58-4ea8-aaa6-f76548726896",
                        "orderCourse": 1,
                        "name": "Meetings",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileMeetings.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:05:53.898Z",
                        "updatedAt": "2021-09-03T05:05:53.898Z"
                    }
                ],
                "categories": [
                    {
                        "id": "f01cf003-25d1-432f-aaab-bf0e8390e14f",
                        "title": "Business English",
                        "description": null,
                        "key": "BUSINESS",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
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
                    },
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
                    }
                ],
                "categories": [
                    {
                        "id": "fb92cf24-1736-4cd7-a042-fa3c37921cf8",
                        "title": "English for Kid",
                        "description": null,
                        "key": "KID",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                "name": "IELTS Speaking Part 2",
                "description": "Practice answering Part 2 questions from past years' IELTS exams",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b9a93c6c4fea72f30b51f?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "0",
                "reason": "Comfort with speaking on your own for an extended period of time will help you ace Part 2 of the IELTS speaking exam.",
                "purpose": "You'll practice speaking at length for Part 2, with tips and tricks recommended by real IELTS examiners. ",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T05:15:27.702Z",
                "updatedAt": "2021-09-03T05:15:27.702Z",
                "topics": [
                    {
                        "id": "c0162ad4-74e7-43a0-8459-319084aff774",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 1,
                        "name": "Art",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileArt.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:15:50.872Z",
                        "updatedAt": "2021-09-03T05:15:50.872Z"
                    },
                    {
                        "id": "9bb62ac2-d748-40f1-841e-a847be9bad14",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 2,
                        "name": "Education",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileEducation.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:15:53.350Z",
                        "updatedAt": "2021-09-03T05:15:53.350Z"
                    },
                    {
                        "id": "b6657f43-517c-4c22-b2ea-7e50ea041db0",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 3,
                        "name": "News and Media",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileNews and Media.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:15:55.887Z",
                        "updatedAt": "2021-09-03T05:15:55.887Z"
                    },
                    {
                        "id": "4da28162-ea2e-4031-8d29-a0fc3b530931",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 4,
                        "name": "Nature and Environment",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileNature and Environment.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:15:58.483Z",
                        "updatedAt": "2021-09-03T05:15:58.483Z"
                    },
                    {
                        "id": "f2a4ff74-37f2-4cfe-bd22-69e79915b6be",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 5,
                        "name": "Friends",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFriends.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:16:00.919Z",
                        "updatedAt": "2021-09-03T05:16:00.919Z"
                    },
                    {
                        "id": "7211be56-46fb-48f1-bc38-3052b82eba36",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 6,
                        "name": "Food and Restaurants",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFood and Restaurants.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:16:03.504Z",
                        "updatedAt": "2021-09-03T05:16:03.504Z"
                    },
                    {
                        "id": "e5b3f7b1-25c4-49ca-aa73-fa9d03d53e15",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 7,
                        "name": "Technology",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileTechnology.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:16:05.978Z",
                        "updatedAt": "2021-09-03T05:16:05.978Z"
                    },
                    {
                        "id": "5d24a658-9205-41e6-a9ac-6032eadc551f",
                        "courseId": "27c36bad-45f4-4cac-950f-f97dc36735f9",
                        "orderCourse": 0,
                        "name": "Holidays and Vacations",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileHolidays and Vacations.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:15:48.584Z",
                        "updatedAt": "2021-09-03T05:15:48.584Z"
                    }
                ],
                "categories": [
                    {
                        "id": "fb92cf24-1736-4cd7-a042-fa3c37921cf8",
                        "title": "English for Kid",
                        "description": null,
                        "key": "KID",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            },
            {
                "id": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                "name": "IELTS Speaking Part 3",
                "description": "Practice answering Part 3 questions from past years' IELTS exams",
                "imageUrl": "https://camblycurriculumicons.s3.amazonaws.com/5e2b9aa00b0a5a7e50456a53?h=d41d8cd98f00b204e9800998ecf8427e",
                "level": "0",
                "reason": "Answering open-ended questions asked by a native speaker is the best way to simulate Part 3 of the IELTS speaking exam.",
                "purpose": "You'll practice answering Part 3 questions from previous years' exams, with tips and tricks recommended by real IELTS examiners. ",
                "other_details": "",
                "default_price": 0,
                "course_price": 0,
                "courseType": null,
                "sectionType": null,
                "visible": true,
                "displayOrder": null,
                "createdAt": "2021-09-03T05:20:27.628Z",
                "updatedAt": "2021-09-03T05:20:27.628Z",
                "topics": [
                    {
                        "id": "f6b2179e-c02b-4f93-8ab9-831970fd6a87",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 1,
                        "name": "Art",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileArt.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:20:55.691Z",
                        "updatedAt": "2021-09-03T05:20:55.691Z"
                    },
                    {
                        "id": "b86b0674-cf0f-4f79-8440-d693e5d0e88a",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 2,
                        "name": "Education",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileEducation.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:20:58.645Z",
                        "updatedAt": "2021-09-03T05:20:58.645Z"
                    },
                    {
                        "id": "fa2e80fc-833c-4792-84f3-d71934cd9b97",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 3,
                        "name": "News and Media",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileNews and Media.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:21:01.654Z",
                        "updatedAt": "2021-09-03T05:21:01.654Z"
                    },
                    {
                        "id": "feb8ade5-ec9b-4192-9abf-950d3394677b",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 4,
                        "name": "Nature and Environment",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileNature and Environment.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:21:04.674Z",
                        "updatedAt": "2021-09-03T05:21:04.674Z"
                    },
                    {
                        "id": "938f248a-a83c-440d-937e-fcf0ec4dbd9b",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 5,
                        "name": "Friends",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFriends.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:21:07.636Z",
                        "updatedAt": "2021-09-03T05:21:07.636Z"
                    },
                    {
                        "id": "eaf39f18-77c1-4a31-870c-888877ba229a",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 6,
                        "name": "Food and Restaurants",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFood and Restaurants.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:21:10.599Z",
                        "updatedAt": "2021-09-03T05:21:10.599Z"
                    },
                    {
                        "id": "81a60bd4-704d-4088-acbd-5f676048ed2d",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 7,
                        "name": "Technology",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileTechnology.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:21:13.662Z",
                        "updatedAt": "2021-09-03T05:21:13.662Z"
                    },
                    {
                        "id": "c956603a-b051-4c93-b1a4-94c63434ec03",
                        "courseId": "ad318948-4e5c-48b3-8cd5-613327b65bd5",
                        "orderCourse": 0,
                        "name": "Holidays and Vacations",
                        "nameFile": "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileHolidays and Vacations.pdf",
                        "numberOfPages": null,
                        "description": "",
                        "videoUrl": null,
                        "type": null,
                        "createdAt": "2021-09-03T05:20:52.858Z",
                        "updatedAt": "2021-09-03T05:20:52.858Z"
                    }
                ],
                "categories": [
                    {
                        "id": "fb92cf24-1736-4cd7-a042-fa3c37921cf8",
                        "title": "English for Kid",
                        "description": null,
                        "key": "KID",
                        "displayOrder": null,
                        "createdAt": "2021-09-05T13:06:10.836Z",
                        "updatedAt": "2021-09-05T13:06:10.836Z"
                    }
                ]
            }
        ]
    }
}


  """;

class MyCourseRepository implements CourseRepository {
  @override
  Future<List<Course>?> getListCourseWithPagination(int page, int size,
      {String q = "", String categoryId = ""}) {
    final res = json.decode(courseJsonString);
    final courses = res['data']['rows'] as List;
    final arr = courses.map((e) => Course.fromJson(e)).toList();
    return Future.value(arr);
  }
}

class RemoteRepository implements CourseRepository {
  @override
  Future<List<Course>?> getListCourseWithPagination(int page, int size,
      {String q = "", String categoryId = ""}) {
    throw UnimplementedError();
  }
}

class CourseFunctions {
  static Future<List<Course>?> getListCourseWithPagination(
    int page,
    int size, {
    String q = "",
    String categoryId = "",
  }) async {
    var storage = const FlutterSecureStorage();
    // String? token = await storage.read(key: 'accessToken');
    String? token = temporaryToken;

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
    // String? token = await storage.read(key: 'accessToken');

    String? token = temporaryToken;

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
    // var storage = const FlutterSecureStorage();
    // String? token = await storage.read(key: 'accessToken');
    String? token = temporaryToken;

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
    // var storage = const FlutterSecureStorage();
    // String? token = await storage.read(key: 'accessToken');
    String? token = temporaryToken;

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
