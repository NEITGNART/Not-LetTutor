import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/common/presentation/blockquote.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/schedule_card.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/controller/schedule_controller.dart';
import 'package:beatiful_ui/src/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constants.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleController c = Get.find();
    c.init();
    return Scaffold(
      body: SafeArea(
        child: ScheduleList(c: c),
      ),
    );
  }
}

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key, required this.c});
  final ScheduleController c;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (c.upcomingClasses.isEmpty) {
        return const Center(child: Text('No booked classes'));
      }

      return ListView.builder(
        itemCount: c.upcomingClasses.length,
        itemBuilder: (context, index) {
          int startTime = c.upcomingClasses.value[index].scheduleDetailInfo!
              .startPeriodTimestamp;
          int endTime = c.upcomingClasses.value[index].scheduleDetailInfo!
              .endPeriodTimestamp;
          final String time =
              '${changeHoursFormat(startTime)} - ${changeHoursFormat(endTime)}';
          final meet = c.upcomingClasses.value[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            child: ScheduleLessonCard(
              meet: meet,
              date: changeDateFormat(startTime),
              lesson: index + 1,
              times: [time],
              tutor: c.upcomingClasses.value[index].scheduleDetailInfo!
                  .scheduleInfo?.tutorInfo,
            ),
          );
        },
      );
    });
  }
}

class ScheduleBanner extends StatelessWidget {
  const ScheduleBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 120,
          height: 120,
          child: SvgPicture.network(
              'https://sandbox.app.lettutor.com/static/media/calendar-check.7cf3b05d.svg'),
        ),
        gapW16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Schedule', style: kTitle1Style),
              gapH12,
              const BlockQuote(
                blockColor: Colors.grey,
                child: Text(
                    '''Here is a list of the sessions you have booked\n\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours'''),
              ),
              // create blockquote using flutter-quill
            ],
          ),
        ),
      ],
    );
  }
}
