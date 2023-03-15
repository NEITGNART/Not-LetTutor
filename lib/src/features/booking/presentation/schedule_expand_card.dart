import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';
import '../../../common/constants.dart';

class RequestLessonCard extends StatelessWidget {
  const RequestLessonCard({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: scheduleBackgroundColor,
      ),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('18:30 - 18:55', style: kCalloutLabelStyle),
                        ElevatedButton.icon(
                          style: const ButtonStyle(
                            // border red
                            // background red
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.white,
                            ),

                            // border color red
                            side: MaterialStatePropertyAll(
                              BorderSide(color: Colors.red),
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          label: Text(
                            'Cancel',
                            style: kSearchPlaceholderStyle.copyWith(
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    gapH16,
                    // expansion panel

                    Container(
                      color: historyBackground,
                      child: Column(
                        children: [
                          Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              collapsedBackgroundColor: historyBackground,
                              initiallyExpanded: isExpanded,
                              title: const Text('Request for lesson'),
                              // disable border
                              tilePadding: const EdgeInsets.all(0),
                              // change color of top and bottom and expand icon
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Edit request',
                                  style: kSearchPlaceholderStyle.copyWith(
                                      color: Colors.blue),
                                ),
                              ),
                              backgroundColor: historyBackground,
                              controlAffinity: ListTileControlAffinity.leading,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(
                                      //     color: const Color.fromARGB(255, 196, 195, 195),
                                      //     width: 1),
                                      border: Border.all(
                                        color: const Color(0xff00b4d8),
                                        width: 0.5,
                                      )),
                                  child: Text(
                                      'Currently there are no requests for this class. Please write down any requests for the teacher.',
                                      style: kSearchPlaceholderStyle.copyWith(
                                          fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheduleReviewBackground,
                ),
                child: Text('Go to meeting', style: kSearchPlaceholderStyle),
              ),
            ],
          )
        ],
      ),
    );
  }
}
