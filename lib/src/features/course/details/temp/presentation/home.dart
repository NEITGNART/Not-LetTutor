import 'package:beatiful_ui/src/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'recent_course_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // context.pushNamed('/profile');
            // open drawer
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              // PageView.builder(itemBuilder: (context, index) {
              //   return CourseCard(course: recentCourses[index]);
              // }),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Recent Courses',
                      style: kLargeTitleStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 340,
                width: double.infinity,
                child: RecentCourseList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Rices',
                      style: kLargeTitleStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
