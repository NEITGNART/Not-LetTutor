import 'package:flutter/material.dart';

import '../../../../../common/app_sizes.dart';
import '../../../../../common/constants.dart';

class RequestLessonCard extends StatelessWidget {
  const RequestLessonCard(
      {super.key,
      required this.isExpanded,
      required this.cb,
      this.times,
      required this.cancelCb});
  final VoidCallback cb;
  final VoidCallback cancelCb;
  final bool isExpanded;
  final List<String>? times;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: scheduleBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...times!.map(
                  (e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(e, style: kCalloutLabelStyle),
                        ElevatedButton.icon(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.white,
                            ),
                            // border color red
                            side: MaterialStatePropertyAll(
                              BorderSide(color: Colors.red),
                            ),
                          ),
                          onPressed: () {
                            cancelCb();
                          },
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          label: Text(
                            'Cancel',
                            style: kSearchPlaceholderStyle.copyWith(
                                color: Colors.red),
                          ),
                        )
                      ],
                    );
                  },
                ),
                // Expanded(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: 6,
                //     itemBuilder: (context, index) {
                //       return GestureDetector(
                //         onTap: () {
                //           cb();
                //         },
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Text('18:30 - 18:55', style: kCalloutLabelStyle),
                //             ElevatedButton.icon(
                //               style: const ButtonStyle(
                //                 // border red
                //                 // background red
                //                 backgroundColor: MaterialStatePropertyAll(
                //                   Colors.white,
                //                 ),

                //                 // border color red
                //                 side: MaterialStatePropertyAll(
                //                   BorderSide(color: Colors.red),
                //                 ),
                //               ),
                //               onPressed: () {},
                //               icon:
                //                   const Icon(Icons.cancel, color: Colors.red),
                //               label: Text(
                //                 'Cancel',
                //                 style: kSearchPlaceholderStyle.copyWith(
                //                     color: Colors.red),
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
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
              ],
            ),
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  cb();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheduleReviewBackground,
                ),
                child: Text(
                  'Go to meeting',
                  style: kSearchPlaceholderStyle.copyWith(
                    color: Colors.blue,
                    //bold
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
