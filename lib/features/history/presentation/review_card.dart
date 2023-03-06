import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';
import '../../../common/constants.dart';
import 'expand_card.dart';

class ReviewHistoryCard extends StatefulWidget {
  const ReviewHistoryCard({super.key});

  @override
  State<ReviewHistoryCard> createState() => _ReviewHistoryCardState();
}

class _ReviewHistoryCardState extends State<ReviewHistoryCard> {
  final Map<String, String> _review = {
    'review': 'This is a review',
    'rating': '5',
  };

  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    var lessonTime = 'Lesson time: 18:30 - 18:55';
    return Container(
        child: Container(
      decoration: const BoxDecoration(
        color: scheduleBackground,
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
                ElevatedButton.icon(
                  style: const ButtonStyle(
                    // border red
                    // background red
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.blue,
                    ),
                    // border color red
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  label: Text(
                    'Record',
                    style:
                        kSearchPlaceholderStyle.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              gapH16,
              // expansion panel
              HistoryExpandCard(isExpanded: isExpanded),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Go to meeting',
                    style: kCaptionLabelStyle.copyWith(
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
