import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_controller.dart';
import 'package:beatiful_ui/src/utils/learning_topics.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/tutor/presentation/tutor_home_page.dart';
import '../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    'All',
    'English for Kids',
    'Business English',
    'Conversational English',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC'
  ];

  final reversedList = {
    for (var k in listLearningTopics.keys) listLearningTopics[k]: k
  };

  int specialityIdx = 0;

  // text controller

  @override
  Widget build(BuildContext context) {
    TutorController c = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.search,
          style: kTitle1Style,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          // unfocus
          onTapOutside: (e) {
            FocusScope.of(context).unfocus();
          },
          autofocus: false,
          controller: c.search,
          decoration: InputDecoration(
            fillColor: Colors.blueGrey.shade50,
            filled: true,
            contentPadding: const EdgeInsets.all(15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            hintText: 'Enter name, country',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.nationality,
          style: kTitle1Style,
        ),
        gapH12,
        ChipsChoice<String>.multiple(
          padding: const EdgeInsets.all(0),
          value: nationalityTutor,
          onChanged: (val) => setState(() {
            logger.i('You just selected $val');
            c.filterByNationality(val);
            nationalityTutor = val;
          }),
          choiceItems: C2Choice.listFrom<String, String>(
            source: options,
            value: (i, v) => v,
            label: (i, v) => v,
          ),
          wrapped: false,
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
        // Text(
        //   'Select available tutoring time:',
        //   style: kTitle2Style.copyWith(
        //     // fontsize
        //     fontSize: 14,
        //   ),
        // ),
        // gapH12,
        // Wrap(
        //   children: [
        //     Container(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(30),
        //           border: Border.all(color: Colors.grey, width: 1),
        //         ),
        //         child: const MyDatePicker()),
        //   ],
        // ),
        // gapH12,
        // Container(
        //   padding: const EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(30),
        //     border: Border.all(color: Colors.grey, width: 1),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Flexible(
        //         flex: 1,
        //         child: TextButton(
        //           onPressed: () {},
        //           child: Text('Start time:',
        //               style: kSearchPlaceholderStyle.copyWith(
        //                 // fontsize
        //                 fontSize: 16,
        //               )),
        //         ),
        //       ),
        //       const Icon(Icons.turn_right_rounded),
        //       Flexible(
        //         flex: 1,
        //         child: TextButton(
        //           onPressed: () {},
        //           child: Text('End time:',
        //               style: kSearchPlaceholderStyle.copyWith(
        //                 // fontsize
        //                 fontSize: 16,
        //               )),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        Text(
          AppLocalizations.of(context)!.spe,
          style: kTitle1Style,
        ),
        gapH12,
        ChipsChoice<int>.single(
            padding: const EdgeInsets.all(0),
            value: specialityIdx,
            choiceItems: C2Choice.listFrom<int, String>(
              source: specialities,
              value: (i, v) => i,
              label: (i, v) => v,
              // tooltip: (i, v) => v,
            ),
            wrapped: false,
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
                specialityIdx = value;
                String specialty =
                    reversedList[specialities[specialityIdx]] ?? all;
                c.filterBySpecialty(specialty);
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
                specialityIdx = 0;
                c.resetFilter();
              });
            },
            child: Text(
              'Reset Filters',
              style: kCalloutLabelStyle.copyWith(color: Colors.blue),
            )),
      ],
    );
  }
}
