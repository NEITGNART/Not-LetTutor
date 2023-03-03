import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';
import '../../../common/constants.dart';
import '../../../common/presentation/group_button_ui.dart';

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
  final List<String> suggestedCourses;
  final String interests;
  final String teachingExperience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Languages', style: kHeadlineLabelStyle),
          gapH24,
          GroupButtonColor(
            titles: languages,
          ),
          const SizedBox(height: 10),
          gapH12,
          Text('Specialties', style: kHeadlineLabelStyle),
          gapH24,
          GroupButtonColor(titles: specialties),
          gapH12,
          Text('Suggested Courses', style: kHeadlineLabelStyle),
          gapH24,
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ...suggestedCourses.map((e) => Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: RichText(
                  //         child: Text(e,
                  //             style: kCardTitleStyle.copyWith(
                  //                 fontSize: 16, color: Colors.black)),
                  //       ),
                  //     ))

                  ...suggestedCourses.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(
                              text: e,
                              style: kCardTitleStyle.copyWith(
                                  fontSize: 16, color: Colors.black),
                              children: [
                            TextSpan(
                                // onTap: () => launch('https://flutter.dev'),q
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
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
          gapH12,
          Text('Interests', style: kHeadlineLabelStyle),
          gapH24,
          Text(
            interests,
            style: kSearchPlaceholderStyle.copyWith(
              fontSize: 14,
            ),
          ),
          gapH12,
          Text('Teaching Experience', style: kHeadlineLabelStyle),
          gapH24,
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
