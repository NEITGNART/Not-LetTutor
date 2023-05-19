import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/common/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/constants.dart';
import '../../../../utils/join_meeting.dart';
import '../controller/tutor_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpComingLesson extends StatelessWidget {
  final bool isUpComingLesson;
  final Duration totalLessonTime;
  final String formatDate;
  final String countDown;
  final VoidCallback cb;

  const UpComingLesson(
      {super.key,
      this.isUpComingLesson = true,
      this.totalLessonTime = const Duration(),
      this.formatDate = 'Sat, 29 Apr 23 01:30 - 01:55',
      this.countDown = '',
      required this.cb});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF00AEFF),
            Color(0xFF0076FF),
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isUpComingLesson) ...[
              Text(
                'Upcoming lesson',
                style: kTitle1Style.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 30),
              buildEnterRoomResponsive(context),
              const SizedBox(height: 15),
              Expanded(
                child: Text(
                  // 'Total lesson time is ${totalLessonTime.inHours} hours ${totalLessonTime.} minutes',
                  'Total lesson time is ${totalLessonTime.inHours} hours ${totalLessonTime.inMinutes - (totalLessonTime.inHours * 60)} minutes',
                  style: kBodyLabelStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ] else ...[
              gapH32,
              Expanded(
                child: Text(AppLocalizations.of(context)!.noUpComming,
                    textAlign: TextAlign.center,
                    style: kTitle1Style.copyWith(color: Colors.white)),
              ),
              gapH16,
              Expanded(
                child: Text(
                  '${AppLocalizations.of(context)!.totalLesson} is ${totalLessonTime.inHours} ${AppLocalizations.of(context)!.hours} ${totalLessonTime.inMinutes - (totalLessonTime.inHours * 60)} ${AppLocalizations.of(context)!.minutes}',
                  style: kBodyLabelStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget buildEnterRoomResponsive(BuildContext context) {
    TutorController c = Get.find();
    if (MediaQuery.of(context).size.width < Breakpoint.desktop) {
      return Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: formatDate,
                  style: kSearchTextStyle.copyWith(
                      color: Colors.white, fontSize: 20),
                ),
                TextSpan(
                  text: '\n(starts in $countDown)',
                  style: kSearchTextStyle.copyWith(
                      color: Colors.amber.shade300, fontSize: 20),
                ),
              ],
            ),
          ),
          gapH12,
          Obx(() {
            if (c.nextClass.value == null) {
              return ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                // color white
                label: const Text('Enter lesson room'),
                // background color white
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                //
                // border radius 20
              );
            }
            return ElevatedButton.icon(
              onPressed: () {
                final meet = c.nextClass.value;
                joinMeeting(meet!);
                // final startTime = DateTime.fromMillisecondsSinceEpoch(
                //     meet!.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
                // final difference = startTime.difference(DateTime.now());
                // if (difference <= const Duration(seconds: 0)) {
                //   joinMeeting(meet);
                // } else {
                //   context.pushNamed(AppRoute.meeting.name,
                //       params: {'id': meet.studentMeetingLink}, extra: meet);
                // }
                // TutorController c = Get.find();
                // context.pushNamed(AppRoute.meeting.name,
                //     params: {'id': c.nextClass.value!.studentMeetingLink},
                //     extra: c.nextClass.value);
              },
              icon: const Icon(Icons.play_arrow),
              // color white
              label: const Text('Enter lesson room'),
              // background color white
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              //
              // border radius 20
            );
          }),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Fri, 30 Sep 22 18:20 - 18:55',
                  style: kSearchTextStyle.copyWith(color: Colors.white),
                ),
                TextSpan(
                  text: '(starts in 65: 43: 51)',
                  style:
                      kSearchTextStyle.copyWith(color: Colors.amber.shade300),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow),
          // color white
          label: const Text('Enter lesson room'),
          // background color white
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.blue),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          //
          // border radius 20
        ),
      ],
    );
  }
}
