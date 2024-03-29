import 'package:beatiful_ui/src/features/course/details/service/course_function.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/app_sizes.dart';
import '../../../../common/constants.dart';
import '../../../../common/presentation/group_button_ui.dart';
import '../../../../route/app_route.dart';
import '../../model/suggested_course.dart';

class TutorInfoCard extends StatelessWidget {
  const TutorInfoCard({
    Key? key,
    required this.languages,
    required this.specialties,
    required this.suggestedCourses,
    required this.interests,
    required this.teachingExperience,
  }) : super(key: key);

  final List<String> languages;
  final List<String> specialties;
  final List<Courses> suggestedCourses;
  final String interests;
  final String teachingExperience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Languages', style: kTitle1Style),
          gapH12,
          SizedBox(
            height: 50,
            child: GroupButtonColor(
              titles: languages,
            ),
          ),
          const SizedBox(height: 10),
          gapH12,
          Text('Specialties', style: kTitle1Style),
          gapH12,
          SizedBox(height: 50, child: GroupButtonColor(titles: specialties)),
          if (suggestedCourses.isNotEmpty) ...{
            Text('Suggested Courses', style: kTitle1Style),
            gapH12,
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...suggestedCourses.map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(
                                text: e.name,
                                style: kCardTitleStyle.copyWith(
                                    fontSize: 16, color: Colors.black),
                                children: [
                              TextSpan(
                                  // onTap: () => launch('https://flutter.dev'),q
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final course =
                                          await CourseFunction.getCourseById(
                                              e.id!);
                                      context.pushNamed(
                                          AppRoute.detailCourse.name,
                                          params: {
                                            'courseId': e.id!,
                                          },
                                          extra: course);
                                    },
                                  text: ': Link',
                                  style: kSubtitleStyle.copyWith(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ))
                            ]))))
                  ],
                ),
              ],
            ),
          },
          gapH12,
          Text('Interests', style: kTitle1Style),
          gapH12,
          Text(
            interests,
            style: kSearchPlaceholderStyle.copyWith(
              fontSize: 14,
            ),
          ),
          gapH12,
          Text('Teaching Experience', style: kTitle1Style),
          gapH12,
          Text(
            teachingExperience,
            style: kSearchPlaceholderStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
