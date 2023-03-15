import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GestureDetector(
                  child: SvgPicture.network(
                    'https://sandbox.app.lettutor.com/static/media/lettutor_logo.91f91ade.svg',
                    width: 170,
                    height: 39,
                  ),
                  // display hover effect
                  //
                  onTap: () => {},
                ),
                // Text(
                //   'LETTUTOR',
                //   style: kHeadlineLabelStyle.copyWith(
                //     color: Colors.blue[600],
                //   ),
                // ),
              ],
            ),
          ),
          // breakpoint

          MediaQuery.of(context).size.width >= 880
              ? Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text('TUTOR', style: kHeadlineLabelStyle),
                        const SizedBox(width: 20.0),
                        Text('SCHEDULE', style: kHeadlineLabelStyle),
                        const SizedBox(width: 20.0),
                        Text('HISTORY', style: kHeadlineLabelStyle),
                        const SizedBox(width: 20.0),
                        Text('MY COURSE', style: kHeadlineLabelStyle),
                      ],
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const IconButton(
                  icon: Icon(Icons.language),
                  onPressed: null,
                ),
                Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // add border color
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: MediaQuery.of(context).size.width > 500
                        ? const Column(
                            children: [
                              Row(
                                children: [
                                  Text('John Pham'),
                                  IconButton(
                                      onPressed: null, icon: Icon(Icons.face)),
                                ],
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'You have 391 lessons left',
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              )),
                            ],
                          )
                        : IconButton(
                            icon: const Icon(Icons.more_vert),
                            // icon more
                            onPressed: () {},
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
