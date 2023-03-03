import 'package:beatiful_ui/common/app_sizes.dart';
import 'package:beatiful_ui/common/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../common/presentation/group_button_ui.dart';
import 'detail_review_card.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key});

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ReviewCard()),
                Placeholder(
                  fallbackHeight: 300,
                  fallbackWidth: 300,
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Flexible(
                    flex: 1,
                    child: EnglishTutor(
                      languages: ['English', 'Vietnamese'],
                      // English for Business, English for Travel, English for Kids
                      specialties: [
                        'English for Business',
                        'English for Conversation',
                        'English for Kids',
                        'IELTS',
                        'TOIEC'
                      ],
                      suggestedCourses: [
                        'English for Business',
                        'English for Travel',
                      ],
                      interests:
                          'I loved the weather, the scenery and the laid-back lifestyle of the locals.',
                      teachingExperience:
                          'I have more than 10 years of teaching english experience',
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EnglishTutor extends StatelessWidget {
  const EnglishTutor({
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
