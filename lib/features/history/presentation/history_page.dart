import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';
import '../../../common/presentation/date_lesson.dart';
import '../../../common/presentation/tutor_info_lesson_cart.dart';
import 'banner.dart';
import 'review_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Column(children: [
          HistoryBanner(),
          gapH16,
          Expanded(child: HistoryList()),
        ]),
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: HistoryLessonCard(
              date: 'Fri, 30, Sep 22',
              lesson: index + 1,
            ),
          );
        },
      ),
    );
  }
}

class HistoryLessonCard extends StatefulWidget {
  final String date;
  final int lesson;
  final String requestContent;

  const HistoryLessonCard(
      {super.key,
      required this.date,
      required this.lesson,
      this.requestContent =
          'Currently there are no requests for this class. Please write down any requests for the teacher.'});

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
                      date: widget.date,
                      lesson: widget.lesson,
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: TutorInfoLessonCard(),
                  ),
                  const Flexible(
                    flex: 2,
                    child: ReviewHistoryCard(),
                  )
                ],
              )
            : SizedBox(
                height: 560,
                child: Column(
                  children: [
                    DateLesson(
                      date: widget.date,
                      lesson: widget.lesson,
                    ),
                    gapH32,
                    const TutorInfoLessonCard(),
                    gapH32,
                    const ReviewHistoryCard()
                  ],
                ),
              ));
  }
}
