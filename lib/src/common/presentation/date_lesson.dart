// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../app_sizes.dart';
import '../constants.dart';

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
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(date, style: kCalloutLabelStyle),
        gapH4,
        Text('${lesson} lesson', style: kSearchPlaceholderStyle),
      ],
    ));
  }
}