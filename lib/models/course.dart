import 'package:flutter/material.dart';

class Course {
  Course({
    required this.courseTitle,
    required this.courseSubtitle,
    required this.background,
    required this.illustration,
    required this.logo,
  });

  String courseTitle;
  String courseSubtitle;
  LinearGradient background;
  String illustration;
  String logo;
}

