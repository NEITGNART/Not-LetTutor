import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../../features/tutor/presentation/tutor_home_page.dart';
import '../constants.dart';
import 'my_date_picker.dart';

class MyFilter extends StatefulWidget {
  const MyFilter({super.key});

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  List<String> nationalityTutor = [];
  List<String> options = [
    'Forein Tutor',
    'Vietnamese Tutor',
    'Native English Tutor',
  ];

  List<String> specialities = [
    'All categories',
    'English for kids',
    'English for Business',
    'Conversational',
    'Starters',
    'Movers',
    'Flyers',
    'KET/PET',
    'TOEIC',
    'IELTS',
    'TOEFL',
  ];

  int speciality = -1;

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
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // radius: 10,
              labelText: 'Enter your tutor name...',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Choose tutor nationality',
            style: kTitle1Style,
          ),
          gapH12,
          ChipsChoice<String>.multiple(
            padding: const EdgeInsets.all(0),
            value: nationalityTutor,
            onChanged: (val) => setState(() {
              logger.i('You just selected $val');
              nationalityTutor = val;
            }),
            choiceItems: C2Choice.listFrom<String, String>(
              source: options,
              value: (i, v) => v,
              label: (i, v) => v,
            ),
            wrapped: true,
            // choiceCheckmark: true,
            choiceStyle: C2ChipStyle.outlined(
              color: Colors.blue,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              selectedStyle: C2ChipStyle.filled(
                  color: Colors.blue, foregroundColor: Colors.white),
            ),
          ),
          gapH12,
          Text(
            'Select available tutoring time:',
            style: kTitle2Style.copyWith(
              // fontsize
              fontSize: 14,
            ),
          ),
          gapH12,
          Wrap(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: const MyDatePicker()),
            ],
          ),
          gapH12,
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Start time:',
                        style: kSearchPlaceholderStyle.copyWith(
                          // fontsize
                          fontSize: 16,
                        )),
                  ),
                ),
                const Icon(Icons.turn_right_rounded),
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('End time:',
                        style: kSearchPlaceholderStyle.copyWith(
                          // fontsize
                          fontSize: 16,
                        )),
                  ),
                ),
              ],
            ),
          ),
          gapH12,
          ChipsChoice<int>.single(
              padding: const EdgeInsets.all(0),
              value: speciality,
              choiceItems: C2Choice.listFrom<int, String>(
                source: specialities,
                value: (i, v) => i,
                label: (i, v) => v,
                // tooltip: (i, v) => v,
              ),
              wrapped: true,
              // choiceCheckmark: true,
              choiceStyle: C2ChipStyle.outlined(
                // color: CustomColor.shadowBlue,
                color: Colors.blue,
                // color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                selectedStyle: C2ChipStyle.filled(
                    color: Colors.blue, foregroundColor: Colors.white),
              ),
              onChanged: (value) {
                setState(() {
                  speciality = value;
                });
              }),
          // GroupButton(titles: allSkillFilter),
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
              onPressed: () {
                setState(() {
                  nationalityTutor = [];
                  speciality = -1;
                });
              },
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
