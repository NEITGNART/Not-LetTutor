import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';
import '../../../common/presentation/date_lesson.dart';
import '../../../common/presentation/tutor_info_lesson_cart.dart';
import 'schedule_expand_card.dart';

class ScheduleLessonCard extends StatefulWidget {
  final String date;
  final int lesson;
  final String requestContent;

  const ScheduleLessonCard(
      {super.key,
      required this.date,
      required this.lesson,
      this.requestContent =
          'Currently there are no requests for this class. Please write down any requests for the teacher.'});

  @override
  State<ScheduleLessonCard> createState() => _ScheduleLessonState();
}

class _ScheduleLessonState extends State<ScheduleLessonCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: scheduleBackground),
      child: MediaQuery.of(context).size.width >= 1000
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: DateLesson(
                    date: widget.date,
                    lesson: widget.lesson,
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: TutorInfoLessonCard(),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: scheduleBackground,
                    ),
                    child: Column(
                      children: [RequestLessonCard(isExpanded: isExpanded)],
                    ),
                  ),
                )
              ],
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
              child: Column(
                children: [
                  DateLesson(
                    date: widget.date,
                    lesson: widget.lesson,
                  ),
                  gapH32,
                  const TutorInfoLessonCard(),
                  gapH32,
                  Expanded(child: RequestLessonCard(isExpanded: isExpanded)),
                ],
              ),
            ),
    );
  }
}
