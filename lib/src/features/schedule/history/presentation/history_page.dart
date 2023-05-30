import 'package:beatiful_ui/src/features/schedule/history/presentation/controller/history_controller.dart';
import 'package:beatiful_ui/src/features/schedule/history/presentation/widgets/index.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/schedule_page.dart';
import 'package:beatiful_ui/src/features/tutor/model/booking_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widget/date_lesson.dart';
import '../../../../common_widget/tutor_info_lesson_cart.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/date_format.dart';
import '../../../tutor/model/tutor.dart';
import '../domain/history.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.history),
      ),
      body: const SafeArea(child: HistoryList()),
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryController c = Get.find();
    c.init();

    return Obx(() {
      if (c.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (c.bookedClasses.isEmpty) {
        return MyEmptyResult(text: AppLocalizations.of(context)!.historyEmpty);
      }

      return ListView.builder(
        itemCount: c.bookedClasses.length,
        itemBuilder: (context, index) {
          int startTime =
              c.bookedClasses[index].scheduleDetailInfo!.startPeriodTimestamp;
          int endTime =
              c.bookedClasses[index].scheduleDetailInfo!.endPeriodTimestamp;
          final String time =
              '${changeHoursFormat(startTime)} - ${changeHoursFormat(endTime)}';

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            child: HistoryLessonCard(
              bookingInfo: c.bookedClasses[index],
              tutor: c.bookedClasses[index].scheduleDetailInfo!.scheduleInfo!
                  .tutorInfo!,
              historyInfo: HistoryInfo(
                date: changeDateFormat(startTime),
                lessonTime: time,
                lesson: 1,
                requestContent: c.bookedClasses[index].studentRequest,
                reviewContent: c.bookedClasses[index].tutorReview,
                videoUrl: c.bookedClasses[index].recordUrl ??
                    'https://www.youtube.com/watch?v=dgFTjSw-oQU',
              ),
            ),
          );
        },
      );
    });
  }
}

class HistoryLessonCard extends StatefulWidget {
  final HistoryInfo historyInfo;
  final Tutor tutor;
  final BookingInfo bookingInfo;
  const HistoryLessonCard(
      {super.key,
      required this.historyInfo,
      required this.tutor,
      required this.bookingInfo});
  @override
  State<HistoryLessonCard> createState() => _HistoryLessonState();
}

class _HistoryLessonState extends State<HistoryLessonCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: scheduleBackgroundColor),
      child: MediaQuery.of(context).size.width >= 1000
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: DateLesson(
                    date: widget.historyInfo.date,
                    lesson: widget.historyInfo.lesson,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TutorInfoLessonCard(tutor: widget.tutor),
                ),
                Flexible(
                  flex: 2,
                  child: ReviewHistoryCard(
                    historyInfo: widget.historyInfo,
                    bookingInfo: widget.bookingInfo,
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateLesson(
                  date: widget.historyInfo.date,
                  lesson: widget.historyInfo.lesson,
                ),
                gapH32,
                TutorInfoLessonCard(tutor: widget.tutor),
                gapH32,
                ReviewHistoryCard(
                  bookingInfo: widget.bookingInfo,
                  historyInfo: widget.historyInfo,
                ),
              ],
            ),
    );
  }
}
