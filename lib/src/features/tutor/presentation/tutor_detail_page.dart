// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_info_card.dart';
import 'package:flutter/material.dart';

import 'detail_review_card.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key});

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Wrap(
                children: [
                  ReviewCard(),
                  Placeholder(
                    fallbackHeight: 300,
                    fallbackWidth: 300,
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Wrap(
                children: [
                  const Expanded(
                    child: TutorInfoCard(
                      languages: ['English', 'Vietnamese'],
                      // English for Business, English for Travel, English for Kids
                      specialties: [
                        'English for Business',
                        'English for Conversation',
                        'English for Kids',
                        'IELTS',
                        'TOIEC'
                      ],
                      suggestedCourses: [
                        'English for Business',
                        'English for Travel',
                      ],
                      interests:
                          'I loved the weather, the scenery and the laid-back lifestyle of the locals.',
                      teachingExperience:
                          'I have more than 10 years of teaching english experience',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                  onPressed: () {}, child: const Text('Today')),
                            ),
                            gapW12,
                            IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_back_ios)),
                            gapW12,
                            IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios)),
                            const Text('Monday, 1st January 2021')
                          ],
                        ),
                        gapH12,
                        BookingTable(),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDate {
  final String day;
  final String month;
  final String nameOfDay;
  CustomDate({
    required this.day,
    required this.month,
    required this.nameOfDay,
  });
}

class BookingTable extends StatelessWidget {
  BookingTable({super.key});
  final calender = [
    // CustomDate(day: , month: month, nameOfDay: nameOfDay)
    // generate 7 days
    CustomDate(day: '1', month: '01', nameOfDay: 'Mon'),
    CustomDate(day: '2', month: '01', nameOfDay: 'Tue'),
    CustomDate(day: '3', month: '01', nameOfDay: 'Wed'),
    CustomDate(day: '4', month: '01', nameOfDay: 'Thu'),
    CustomDate(day: '5', month: '01', nameOfDay: 'Fri'),
    CustomDate(day: '6', month: '01', nameOfDay: 'Sat'),
    CustomDate(day: '7', month: '01', nameOfDay: 'Sun'),
  ];
  final lectureDuration = [
    '00:00 - 01:00',
    '01:00 - 02:00',
    '02:00 - 03:00',
    '03:00 - 04:00',
    '04:00 - 05:00',
    '05:00 - 06:00',
    '06:00 - 07:00',
    '07:00 - 08:00',
  ];

  final Map<String, Map<String, int>> timeTable = {
    '00:00 - 01:00': {
      '1/01': 1, // 1 is available
      '2/01': 0, // 0 is not available
      '3/01': 2, // 2 is booked
      '4/01': 0,
      '5/01': 0,
      '6/01': 0,
      '7/01': 0,
    },
    '01:00 - 02:00': {
      '1/01': 1,
      '2/01': 0,
      '3/01': 2,
      '4/01': 0,
      '5/01': 0,
      '6/01': 0,
      '7/01': 0,
    },
    '02:00 - 03:00': {
      '1/01': 1,
      '2/01': 0,
      '3/01': 2,
      '4/01': 0,
      '5/01': 0,
      '6/01': 0,
      '7/01': 0,
    },
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        // show grid cell
        showBottomBorder: true,
        showCheckboxColumn: true,

        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          // padding = 0
        ),
        columns: <DataColumn>[
          DataColumn(
            label: Container(
              child: const Expanded(
                child: Text(
                  '',
                ),
              ),
            ),
          ),
          ...calender.map((e) {
            return DataColumn(
                label: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${e.day}/${e.month}'),
                gapH4,
                Text(e.nameOfDay),
              ],
            )));
          }),
        ],
        rows: <DataRow>[
          // DataRow(
          //   cells: <DataCell>[
          //     DataCell(
          //       Container(
          //         color: Colors.grey,
          //         child: const Text('00:00 - 00:25'),
          //       ),
          //     ),
          //     DataCell(
          //         ElevatedButton(onPressed: () {}, child: const Text('Book'))),
          //     const DataCell(Text('19')),
          //     const DataCell(Text('Student')),
          //   ],
          // ),

          ...lectureDuration.map(
            (duration) => DataRow(
              cells: <DataCell>[
                DataCell(Text(duration,
                    style: const TextStyle(
                        // bold text
                        fontWeight: FontWeight.bold))),
                ...calender.map((date) {
                  if (timeTable[duration]?['${date.day}/${date.month}'] == 1) {
                    return DataCell(ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Book', style: TextStyle(fontSize: 12)),
                    ));
                  }

                  if (timeTable[duration]?['${date.day}/${date.month}'] == 0) {
                    return const DataCell(Text(''));
                  }

                  if (timeTable[duration]?['${date.day}/${date.month}'] == 2) {
                    return const DataCell(Text('Booked',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)));
                  }

                  return const DataCell(Text(''));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
