import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/controller/schedule_controller.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/widgets/schedule_card.dart';
import 'package:beatiful_ui/src/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/presentation/pagination.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleController c = Get.find();
    c.init();
    return Scaffold(
      body: SafeArea(
        child: ScheduleList(c: c),
      ),
    );
  }
}

class ScheduleList extends StatefulWidget {
  const ScheduleList({super.key, required this.c});
  final ScheduleController c;

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (widget.c.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (widget.c.upcomingClasses.isEmpty) {
              return const Center(child: Text('No booked classes'));
            }

            return ListView.builder(
              itemCount: widget.c.upcomingClasses.length,
              itemBuilder: (context, index) {
                int startTime = widget.c.upcomingClasses[index]
                    .scheduleDetailInfo!.startPeriodTimestamp;
                int endTime = widget.c.upcomingClasses[index]
                    .scheduleDetailInfo!.endPeriodTimestamp;
                final String time =
                    '${changeHoursFormat(startTime)} - ${changeHoursFormat(endTime)}';
                final meet = widget.c.upcomingClasses[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(8),
                  child: ScheduleLessonCard(
                    meet: meet,
                    date: changeDateFormat(startTime),
                    lesson: index + 1,
                    times: [time],
                    tutor: widget.c.upcomingClasses[index].scheduleDetailInfo!
                        .scheduleInfo?.tutorInfo,
                  ),
                );
              },
            );
          }),
        ),
        Obx(() {
          if (widget.c.totalPage.value == 0) {
            return const SizedBox();
          }

          int show =
              widget.c.totalPage.value > 4 ? 2 : widget.c.totalPage.value - 1;
          int totalPage = widget.c.totalPage.value;
          int currentPage = widget.c.currentPage.value;

          return PaginationWidget(
              totalPage: totalPage,
              show: show,
              currentPage: currentPage,
              cb: (number) {
                widget.c.goToPage(number);
              });
        })
      ],
    );
  }
}

// class ScheduleBanner extends StatelessWidget {
//   const ScheduleBanner({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(
//           width: 120,
//           height: 120,
//           child: SvgPicture.network(
//               'https://sandbox.app.lettutor.com/static/media/calendar-check.7cf3b05d.svg'),
//         ),
//         gapW16,
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('Schedule', style: kTitle1Style),
//               gapH12,
//               const BlockQuote(
//                 blockColor: Colors.grey,
//                 child: Text(
//                     '''Here is a list of the sessions you have booked\n\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours'''),
//               ),
//               // create blockquote using flutter-quill
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
