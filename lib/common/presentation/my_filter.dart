import 'package:beatiful_ui/common/presentation/group_button.dart';
import 'package:flutter/material.dart';

import '../../features/tutor/presentation/tutor_home_page.dart';
import '../constants.dart';
import 'my_date_picker.dart';
import 'my_time_picker.dart';

class MyFilter extends StatelessWidget {
  const MyFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find a tutor',
            style: kTitle1Style,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // radius: 10,
                    labelText: 'Enter your tutor name...',
                  ),
                ),
              ),
              Expanded(
                child: _autoCompleteTextField(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text('Select available tutoring time:',
              style: kTitle2Style.copyWith(
                // fontsize
                fontSize: 14,
              )),
          Row(
            children: [
              Container(
                  width: 150,
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: const MyDatePicker()),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: const MyTimePicker(
                        title: 'Start time:',
                      ),
                    )),
                    const Icon(Icons.turn_right_rounded),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: const MyTimePicker(
                            title: 'End time:',
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          GroupButton(titles: allSkillFilter),
          // Wrap(
          //   children: <Widget>[
          //     ...allSkillFilter.map(
          //       (title) => Padding(
          //           padding: const EdgeInsets.all(5.0),
          //           child: ElevatedButton(
          //               onPressed: () {
          //                 // change blue color
          //                 logger.i('You just selected $title');
          //               },

          //               // border for button
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor:
          //                     const Color.fromARGB(255, 228, 230, 235),
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(30),
          //                 ),
          //               ),
          //               child: Text(title,
          //                   style: kSearchTextStyle.copyWith(
          //                       color: const Color.fromARGB(
          //                           255, 100, 100, 100))))),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Reset Filters',
                style: kCalloutLabelStyle.copyWith(color: Colors.blue),
              )),
        ],
      ),
    );
  }

  _autoCompleteTextField() {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return fruits.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
