import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/schedule_expand_card.dart';
import 'package:beatiful_ui/src/features/tutor/model/booking_info.dart';
import 'package:beatiful_ui/src/utils/join_meeting.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/app_sizes.dart';
import '../../../../common/presentation/date_lesson.dart';
import '../../../../common/presentation/tutor_info_lesson_cart.dart';
import '../../../../route/app_route.dart';
import '../../../tutor/model/tutor.dart';

class ScheduleLessonCard extends StatefulWidget {
  final String date;
  final int lesson;
  final String requestContent;
  final List<String>? times;
  final Tutor? tutor;
  final BookingInfo? meet;

  const ScheduleLessonCard(
      {super.key,
      required this.date,
      required this.lesson,
      required this.times,
      required this.tutor,
      required this.meet,
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
                Flexible(
                  flex: 1,
                  child: TutorInfoLessonCard(
                    tutor: widget.tutor!,
                  ),
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
                TutorInfoLessonCard(tutor: widget.tutor!),
                gapH32,
                RequestLessonCard(
                    isExpanded: isExpanded,
                    times: widget.times,
                    cb: () {
                      // Note: We are hard coding student meeting link here
                      // If this is a teacher, we need to change link here

                      final startTime = DateTime.fromMillisecondsSinceEpoch(
                          widget.meet!.scheduleDetailInfo
                                  ?.startPeriodTimestamp ??
                              0);
                      final difference = startTime.difference(DateTime.now());
                      if (difference <= const Duration(seconds: 0)) {
                        joinMeeting(widget.meet!);
                      } else {
                        context.pushNamed(AppRoute.meeting.name,
                            params: {'id': widget.meet!.studentMeetingLink},
                            extra: widget.meet);
                      }
                    }),
              ],
            ),
    );
  }
}
