import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/widgets/schedule_expand_card.dart';
import 'package:beatiful_ui/src/features/tutor/model/booking_info.dart';
import 'package:beatiful_ui/src/utils/join_meeting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/app_sizes.dart';
import '../../../../../common/presentation/date_lesson.dart';
import '../../../../../common/presentation/tutor_info_lesson_cart.dart';
import '../../../../../route/app_route.dart';
import '../../../../tutor/model/tutor.dart';
import '../controller/schedule_controller.dart';

class ScheduleLessonCard extends StatelessWidget {
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

  final bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final ScheduleController c = Get.find();
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
                    date: date,
                    lesson: lesson,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TutorInfoLessonCard(
                    tutor: tutor!,
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
                          cancelCb: () {},
                          isExpanded: isExpanded,
                          cb: () {},
                          times: times,
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
                  date: date,
                  lesson: lesson,
                ),
                gapH16,
                TutorInfoLessonCard(tutor: tutor!),
                gapH32,
                RequestLessonCard(
                    isExpanded: isExpanded,
                    times: times,
                    cancelCb: () async {
                      final now = DateTime.now();
                      final start = DateTime.fromMillisecondsSinceEpoch(
                          meet!.scheduleDetailInfo!.startPeriodTimestamp);
                      if (start.isAfter(now) &&
                          now.difference(start).inHours.abs() >= 2) {
                        final res = await c.cancelClass(meet!.id);
                        c.init();
                        if (res) {
                          Get.snackbar('Success', 'Cancel class success');
                        }
                      } else {
                        Get.snackbar('Error',
                            'You can only cancel class 2 hours before class start');
                      }
                    },
                    cb: () {
                      // Note: We are hard coding student meeting link here
                      // If this is a teacher, we need to change link here

                      final startTime = DateTime.fromMillisecondsSinceEpoch(
                          meet!.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
                      final difference = startTime.difference(DateTime.now());
                      if (difference <= const Duration(seconds: 0)) {
                        joinMeeting(meet!);
                      } else {
                        context.pushNamed(AppRoute.meeting.name,
                            params: {'id': meet!.studentMeetingLink},
                            extra: meet);
                      }
                    }),
              ],
            ),
    );
  }
}
