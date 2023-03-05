import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_sizes.dart';
import '../../../common/constants.dart';

class ScheduleLessonCard extends StatefulWidget {
  final String date;
  final int lesson;
  final String requestContent;

  const ScheduleLessonCard(
      {super.key,
      required this.date,
      required this.lesson,
      this.requestContent =
          'Currently there are no requests for this class. Please write down any requests for the teacher.'});

  @override
  State<ScheduleLessonCard> createState() => _ScheduleLessonState();
}

class _ScheduleLessonState extends State<ScheduleLessonCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: scheduleBackground),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.date, style: kCalloutLabelStyle),
              gapH4,
              Text('${widget.lesson} lesson', style: kSearchPlaceholderStyle),
            ],
          ),
          SizedBox(
            width: 250,
            child: Row(
              children: [
                const CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4')),
                const SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'John Pham',
                        overflow: TextOverflow.ellipsis,
                        style: kHeadlineLabelStyle,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        SvgPicture.network(
                          'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
                          width: 20,
                        ),
                        const SizedBox(width: 5.0),
                        Text('Viet Nam', style: kSearchPlaceholderStyle),
                        const SizedBox(width: 5.0),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    ElevatedButton.icon(
                        // set elevation to 0
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 222, 220, 220))),
                        onPressed: () {},
                        icon: const Icon(Icons.chat, color: Colors.blue),
                        label: Text('Direct Message',
                            style: kSearchPlaceholderStyle.copyWith(
                                color: Colors.blue)))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: scheduleBackground,
              ),
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
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(cardColor: const Color(0xfffafafa)),
                          child: ExpansionPanelList(
                            dividerColor: Colors.lightBlueAccent,
                            // add color
                            expansionCallback: (int index, bool isOpen) {
                              setState(() {
                                isExpanded = !isOpen;
                              });
                            },
                            children: [
                              ExpansionPanel(
                                isExpanded: isExpanded,
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return const ListTile(
                                    // title: Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     const Text('Request for lesson'),
                                    //     TextButton(
                                    //         onPressed: () {},
                                    //         child: const Text('Edit Request'))
                                    //   ],
                                    // ),
                                    title: Text('Request for lesson'),
                                  );
                                },
                                // expand icon on left
                                canTapOnHeader: true,
                                body: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Expanded(
                                    child: Text(widget.requestContent,
                                        style: kSearchPlaceholderStyle.copyWith(
                                            fontSize: 15)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
