import 'package:beatiful_ui/common/app_sizes.dart';
import 'package:beatiful_ui/common/presentation/blockquote.dart';
import 'package:beatiful_ui/features/booking/presentation/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Column(children: [
          ScheduleBanner(),
          gapH16,
          // Expanded(
          //   child: ScheduleList(),
          // ),
        ]),
      ),
    );
  }
}

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ScheduleLessonCard(
            date: 'Fri, 30, Sep 22',
            lesson: index + 1,
          );
        },
      ),
    );
  }
}

class ScheduleBanner extends StatelessWidget {
  const ScheduleBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
