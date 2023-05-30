import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/controller/schedule_controller.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/widgets/schedule_card.dart';
import 'package:beatiful_ui/src/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common_widget/pagination.dart';
import '../../../../constants/constants.dart';

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
              return MyEmptyResult(
                text: AppLocalizations.of(context)!.noClassBook,
              );
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

class MyEmptyResult extends StatelessWidget {
  const MyEmptyResult({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset('asset/images/empty.png'),
          ),
          Text(text,
              style: kCaptionLabelStyle.copyWith(
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}
