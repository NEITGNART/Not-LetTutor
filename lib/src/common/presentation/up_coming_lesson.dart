import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/common/breakpoint.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Time {
  final int? hour;
  final int? minute;

  const Time({this.hour, this.minute});
}

class UpComingLesson extends StatelessWidget {
  final bool isUpComingLesson;
  final totalLessonTime;

  const UpComingLesson(
      {super.key, this.isUpComingLesson = true, this.totalLessonTime = 290});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 200,
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
              const SizedBox(height: 30),
              Expanded(
                child: Text(
                  'Total lesson time is $totalLessonTime hours 25 minutes',
                  style: kBodyLabelStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ] else ...[
              Expanded(
                child: Text('You have no upcoming lesson.',
                    style: kTitle1Style.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Text(
                  'Total lesson time is 290 hours 25 minutes',
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
    if (MediaQuery.of(context).size.width < Breakpoint.desktop) {
      return Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Fri, 30 Sep 22 18:20 - 18:55',
                  style: kSearchTextStyle.copyWith(color: Colors.white),
                ),
                TextSpan(
                  text: '(starts in 65: 43: 51)',
                  style: kSearchTextStyle.copyWith(color: Colors.amber),
                ),
              ],
            ),
          ),
          gapH12,
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
                  style: kSearchTextStyle.copyWith(color: Colors.amber),
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
