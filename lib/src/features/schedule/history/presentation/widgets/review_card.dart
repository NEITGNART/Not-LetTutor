import 'package:beatiful_ui/src/features/tutor/model/booking_info.dart';
import 'package:beatiful_ui/src/utils/join_meeting.dart';
import 'package:flutter/material.dart';

import '../../../../../common/app_sizes.dart';
import '../../../../../common/constants.dart';
import '../../domain/history.dart';
import 'expand_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewHistoryCard extends StatefulWidget {
  final HistoryInfo historyInfo;
  final BookingInfo bookingInfo;
  const ReviewHistoryCard(
      {super.key, required this.historyInfo, required this.bookingInfo});
  @override
  State<ReviewHistoryCard> createState() => _ReviewHistoryCardState();
}

class _ReviewHistoryCardState extends State<ReviewHistoryCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    var lessonTime = 'Lesson time: \n${widget.historyInfo.lessonTime}';
    return Container(
      decoration: const BoxDecoration(
        color: scheduleBackgroundColor,
      ),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(lessonTime,
                      style: kCalloutLabelStyle.copyWith(
                        // no bold
                        fontWeight: FontWeight.normal,
                      )),
                ),
                // ElevatedButton.icon(
                //   style: const ButtonStyle(
                //     // border red
                //     // background red
                //     backgroundColor: MaterialStatePropertyAll(
                //       Colors.blue,
                //     ),
                //     // border color red
                //   ),
                //   onPressed: () {},
                //   icon: const Icon(Icons.play_arrow, color: Colors.white),
                //   label: Text(
                //     'Record',
                //     style:
                //         kSearchPlaceholderStyle.copyWith(color: Colors.white),
                //   ),
                // )
              ],
            ),
          ),
          Column(mainAxisSize: MainAxisSize.min, children: [
            gapH16,
            // expansion panel
            HistoryExpandCard(
                isExpanded: isExpanded, historyInfo: widget.historyInfo),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await joinMeeting(widget.bookingInfo);
                },
                child: Text(AppLocalizations.of(context)!.goMeeting,
                    style: kCaptionLabelStyle.copyWith(
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
