// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/common/breakpoint.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/widget/bottom_dialog.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/widget/tutor_info_card.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/learning_topics.dart';
import 'controller/tutor_controller.dart';
import 'widget/detail_review_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorDetailPage extends StatefulWidget {
  final String tutorId;
  const TutorDetailPage({super.key, required this.tutorId});

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  DetailTutorController c = Get.find();

  @override
  void initState() {
    super.initState();
    c.getTutor(widget.tutorId);
    c.getReviews(widget.tutorId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tutorDetail),
        leading: IconButton(
          onPressed: () {
            Get.back();
            final TutorController tutorC = Get.find();
            tutorC.init();
            c.dispose();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (c.chewieController.value == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(
                  color: Colors.black,
                  height: 250,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Chewie(
                      controller: c.chewieController.value as ChewieController),
                );
              }),
              const TutorInfo(),
              Obx(() => buildReponsive(context, c))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          c.getSchedules(widget.tutorId);
          showTutorDatePicker(context, c);
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }

  Widget buildReponsive(BuildContext context, DetailTutorController c) {
    if (c.tutorValue == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final specilities = (c.tutorValue?.specialties ?? "").split(',').map((e) {
      return listLearningTopics[e] ?? e;
    }).toList();

    // final suggestedCourse = c.tutorValue
    // String specialty = listLearningTopics[title] ?? title;
    if (MediaQuery.of(context).size.width < Breakpoint.desktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TutorInfoCard(
              languages: const ['English', 'Vietnamese'],
              // English for Business, English for Travel, English for Kids
              specialties: specilities,
              suggestedCourses: c.tutorValue!.courses ?? [],
              interests: c.tutorValue!.interests?.trim() ?? "",
              teachingExperience: c.tutorValue!.experience ?? ""),
        ],
      );
    }

    // dispose

    @override
    void dispose() {
      Get.delete(tag: widget.tutorId);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: TutorInfoCard(
            languages: const ['English', 'Vietnamese'],
            // English for Business, English for Travel, English for Kids
            specialties: const [
              'English for Business',
              'English for Conversation',
              'English for Kids',
              'IELTS',
              'TOIEC'
            ],
            suggestedCourses: const [],
            interests: c.tutorValue!.interests ?? "",
            teachingExperience:
                'I have more than 10 years of teaching english experience',
          ),
        ),
        const Flexible(
          flex: 2,
          child: MyBookingTable(),
        )
      ],
    );
  }
}

class MyBookingTable extends StatelessWidget {
  const MyBookingTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              height: 32,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Today')),
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
    );
  }
}

class TutorInfo extends StatelessWidget {
  const TutorInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return buildReponsive(context);
  }

  Widget buildReponsive(BuildContext context) {
    if (MediaQuery.of(context).size.width < Breakpoint.desktop) {
      return const Column(
        children: [
          ReviewCard(),
          gapH20,
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Flexible(flex: 1, child: ReviewCard()),
        Flexible(
            flex: 2,
            child: Image.network(
                fit: BoxFit.cover,
                'https://media.istockphoto.com/id/1299533315/vector/video-player-interface-isolated-on-white-background-video-streaming-template-design-for.jpg?s=612x612&w=0&k=20&c=PLv8Wc5gpJ_6qd_mXGZgPJ0Q6XZ90PzzdPJrh831PGI=')),
      ],
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
          const DataColumn(
            label: Expanded(
              child: Text(
                '',
              ),
            ),
          ),
          ...calender.map((e) {
            return DataColumn(
                label: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${e.day}/${e.month}'),
                gapH4,
                Text(e.nameOfDay),
              ],
            ));
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
