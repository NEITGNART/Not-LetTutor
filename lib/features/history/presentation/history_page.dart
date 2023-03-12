import 'package:beatiful_ui/common/presentation/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/app_sizes.dart';
import '../../../common/presentation/date_lesson.dart';
import '../../../common/presentation/tutor_info_lesson_cart.dart';
import '../data/history_repository.dart';
import '../domain/history.dart';
import 'banner.dart';
import 'review_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          // child: SingleChildScrollView(
          //   child: Container(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Column(children: [
          //       const HistoryBanner(),
          //       gapH16,
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height,
          //         child: const HistoryList(),
          //       ),
          //     ]),
          //   ),
          // ),
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Column(children: [
          HistoryBanner(),
          gapH16,
          Expanded(child: HistoryList()),
        ]),
      )),
    );
  }
}

class HistoryList extends ConsumerWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyValue = ref.watch(historyProvider);

    return AsyncValueWidget<List<HistoryInfo>>(
        value: historyValue,
        data: (historyInfo) => Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: HistoryLessonCard(
                      historyInfo: historyInfo[index],
                    ),
                  );
                },
              ),
            ));
  }
}

class HistoryLessonCard extends StatefulWidget {
  final HistoryInfo historyInfo;
  const HistoryLessonCard({super.key, required this.historyInfo});

  @override
  State<HistoryLessonCard> createState() => _HistoryLessonState();
}

class _HistoryLessonState extends State<HistoryLessonCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(color: scheduleBackground),
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
                  const Flexible(
                    flex: 1,
                    child: TutorInfoLessonCard(),
                  ),
                  Flexible(
                    flex: 2,
                    child: ReviewHistoryCard(
                      historyInfo: widget.historyInfo,
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  DateLesson(
                    date: widget.historyInfo.date,
                    lesson: widget.historyInfo.lesson,
                  ),
                  gapH32,
                  const TutorInfoLessonCard(),
                  gapH32,
                  ReviewHistoryCard(
                    historyInfo: widget.historyInfo,
                  ),
                ],
              ));
  }
}
