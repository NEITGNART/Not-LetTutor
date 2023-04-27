import 'package:beatiful_ui/src/features/booking/presentation/schedule_expand_card.dart';
import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';
import '../../../common/presentation/date_lesson.dart';
import '../../../common/presentation/tutor_info_lesson_cart.dart';

class ScheduleLessonCard extends StatefulWidget {
  final String date;
  final int lesson;
  final String requestContent;
  final List<String>? times;

  const ScheduleLessonCard(
      {super.key,
      required this.date,
      required this.lesson,
      required this.times,
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: scheduleBackgroundColor,
      ),
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
                      color: scheduleBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: RequestLessonCard(
                          isExpanded: isExpanded,
                          cb: () {},
                          times: widget.times,
                        ))
                      ],
                    ),
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateLesson(
                  date: widget.date,
                  lesson: widget.lesson,
                ),
                gapH16,
                const TutorInfoLessonCard(),
                gapH32,
                RequestLessonCard(
                  isExpanded: isExpanded,
                  cb: () {},
                  times: widget.times,
                ),
              ],
            ),
    );
  }
}
