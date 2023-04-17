import 'package:beatiful_ui/src/features/course/details/temp/models/course.dart';
import 'package:beatiful_ui/src/common/constants.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: course.background,
            boxShadow: [
              BoxShadow(
                color: course.background.colors[0].withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: course.background.colors[1].withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                  left: 32.0,
                  right: 32.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.courseSubtitle, style: kCardSubtitleStyle),
                    Text(
                      course.courseTitle,
                      style: kCardTitleStyle,
                    ),
                    // Image.asset('asset/illustrations/${course.illustration}')
                  ],
                ),
              ),
              Expanded(
                child: Image.asset('asset/illustrations/${course.illustration}',
                    fit: BoxFit.cover),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 45.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Image.asset('asset/logos/${course.logo}'),
        ),
      ),
    ]);
  }
}
