import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';
import '../../../common/constants.dart';

// create a data class has title and content for expand card

class Enum {
  static const String request = 'request';
  static const String review = 'review';
}

class HistoryReview {
  final String? title;
  final String? content;
  HistoryReview({this.title, this.content});
}

class HistoryExpandCard extends StatelessWidget {
  final List<HistoryReview> reviews = [
    HistoryReview(
        title: 'How was the lesson?',
        content:
            'Currently there are no requests for this class. Please write down any requests for the teacher.'),
    HistoryReview(
        title: 'How was the lesson?',
        content:
            'Currently there are no requests for this class. Please write down any requests for the teacher.'),
  ];
  HistoryExpandCard({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    var review =
        'Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. Currently there are no requests for this class. Please write down any requests for the teacher. ';
    return Container(
      color: historyBackground,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Column(
            children: [
              Theme(
                // data: null,
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: isExpanded,
                  title: Text('No request for lesson',
                      style: kBodyLabelStyle.copyWith(fontSize: 14)),
                  trailing: const SizedBox(),
                  backgroundColor: Colors.white,
                  children: [
                    Container(),
                  ],
                ),
              ),
              ExpansionTile(
                initiallyExpanded: isExpanded,
                title: Text('Review from tutor',
                    style: kBodyLabelStyle.copyWith(fontSize: 14)),
                // disable border
                // change color of top and bottom and expand icon

                // trailing: TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Edit request',
                //     style: kSearchPlaceholderStyle.copyWith(color: Colors.blue),
                //   ),
                // ),
                backgroundColor: historyBackground,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(review,
                            style:
                                kSearchPlaceholderStyle.copyWith(fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
              // ExpansionTile(
              //   initiallyExpanded: isExpanded,
              //   title: GestureDetector(
              //     child: Text('Review from tutor',
              //         style: kBodyLabelStyle.copyWith(fontSize: 14)),
              //   ),
              //   // disable border
              //   // change color of top and bottom and expand icon
              //   leading: TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       'Edit request',
              //       style: kSearchPlaceholderStyle.copyWith(color: Colors.blue),
              //     ),
              //   ),
              //   trailing: TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       'Edit request',
              //       style: kSearchPlaceholderStyle.copyWith(color: Colors.blue),
              //     ),
              //   ),
              //   backgroundColor: historyBackground,
              // ),
              ListTile(
                leading: TextButton(
                  // padding: const EdgeInsets.all(0),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {},
                  child: Text('Add a Rating',
                      style: kSearchPlaceholderStyle.copyWith(
                          color: Colors.blue, fontSize: 14)),
                ),
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Edit request',
                    style: kSearchPlaceholderStyle.copyWith(
                        color: Colors.blue, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
