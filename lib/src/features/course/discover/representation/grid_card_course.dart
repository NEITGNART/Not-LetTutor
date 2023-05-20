import 'package:flutter/material.dart';

import '../model/course.dart';
import 'course_card.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    super.key,
    required List<Course> results,
    required this.listLevels,
    this.gridNum = 2,
  }) : _results = results;

  final List<Course> _results;
  final Map<String, String> listLevels;
  final int gridNum;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridNum,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) =>
          CourseCard(results: _results, listLevels: listLevels, index: index),
    );
  }
}
