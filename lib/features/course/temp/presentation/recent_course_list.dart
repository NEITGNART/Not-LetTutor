import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/course_repository.dart';
import './recent_course_card.dart';
import 'loading_course.dart';

class RecentCourseList extends ConsumerStatefulWidget {
  const RecentCourseList({super.key});

  @override
  ConsumerState<RecentCourseList> createState() => _RecentCourseListState();
}

class _RecentCourseListState extends ConsumerState<RecentCourseList> {
  int currentPage = 1;
  final controller = PageController(initialPage: 1, viewportFraction: 0.5);
  final indicators = List.generate(4, (index) => index);

  Widget updateIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...indicators.map((e) {
          final int index = indicators.indexOf(e);
          return Container(
            width: 7.0,
            height: 7.0,
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == index ? Colors.blue : Colors.grey,
            ),
          );
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final recentCourseListValue = ref.watch(recentCourseListProvider);
    return recentCourseListValue.when(
        data: (recentCourses) {
          // EasyLoading.dismiss();
          return Column(
            children: [
              Container(
                height: 320,
                width: double.infinity,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return Opacity(
                        opacity: currentPage == index ? 1 : 0.5,
                        child: CourseCard(course: recentCourses[index]));
                  },
                  itemCount: recentCourses.length,
                  controller: controller,
                  onPageChanged: (value) => {
                    setState(() {
                      currentPage = value;
                    })
                  },
                ),
              ),
              updateIndicator()
            ],
          );
        },
        error: (error, stacktrace) => Text(stacktrace.toString()),
        loading: () {
          // EasyLoading.show(
          //   status: 'Loading...',
          // );

          return const LoadingCourse();
        });
  }
}
