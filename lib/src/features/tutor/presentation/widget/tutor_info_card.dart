import 'package:beatiful_ui/src/features/course/details/service/course_function.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widget/group_button_ui.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/constants.dart';
import '../../../../route/app_route.dart';
import '../../model/suggested_course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Text(AppLocalizations.of(context)!.language, style: kTitle1Style),
          gapH12,
          SizedBox(
            height: 50,
            child: GroupButtonColor(
              titles: languages,
            ),
          ),
          const SizedBox(height: 10),
          gapH12,
          Text(AppLocalizations.of(context)!.specialized, style: kTitle1Style),
          gapH12,
          SizedBox(height: 50, child: GroupButtonColor(titles: specialties)),
          if (suggestedCourses.isNotEmpty) ...{
            Text(AppLocalizations.of(context)!.suggestCourse,
                style: kTitle1Style),
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
          Text(AppLocalizations.of(context)!.interests, style: kTitle1Style),
          gapH12,
          Text(
            interests,
            style: kSearchPlaceholderStyle.copyWith(
              fontSize: 14,
            ),
          ),
          gapH12,
          Text(AppLocalizations.of(context)!.teachingExp, style: kTitle1Style),
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
