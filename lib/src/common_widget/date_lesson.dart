import 'package:flutter/material.dart';
import '../constants/constants.dart';

class DateLesson extends StatelessWidget {
  final String date;
  final int lesson;
  const DateLesson({
    Key? key,
    required this.date,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(date, style: kCalloutLabelStyle.copyWith(fontSize: 18)),
        // gapH4,
        // Text(lesson == 1 ? '1 lesson' : '$lesson consecutive lessons',
        //     style: kSearchPlaceholderStyle.copyWith(
        //         color: Colors.black, fontSize: 16)),
      ],
    );
  }
}
