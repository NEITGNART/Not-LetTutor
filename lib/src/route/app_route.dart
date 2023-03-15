import 'package:beatiful_ui/src/features/course/details/presentation/course_detail_page.dart';
import 'package:beatiful_ui/src/features/course/discover/representation/discovery_page.dart';
import 'package:beatiful_ui/src/features/course/temp/presentation/home.dart';
import 'package:beatiful_ui/main.dart';
import 'package:beatiful_ui/src/features/profile/presentation/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/course/details/presentation/lesson_detail_page.dart';

enum AppRoute {
  courseDetail,
  home,
  discovery,
  topicPdf,
}

final configRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const RootPage(),
        routes: [
          GoRoute(
            path: 'profile',
            // builder: (context, state) => const ProfilePage(),
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const ProfilePage(),
              fullscreenDialog: true,
            ),
          ),
          GoRoute(
            name: AppRoute.courseDetail.name,
            path: 'detail_course/:courseId',
            // builder: (context, state) {
            //   final courseId = state.params['courseId'] ?? '';
            //   return DetailCourseScreen(
            //     courseId: courseId,
            //   );
            // },
            pageBuilder: (context, state) {
              final courseId = state.params['courseId'] ?? '';
              return MaterialPage<void>(
                key: state.pageKey,
                child: DetailCourseScreen(
                  courseId: courseId,
                ),
                fullscreenDialog: true,
              );
            },
          ),
          GoRoute(
            path: 'home',
            // builder: (context, state) => const HomePage(),
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const HomePage(),
              fullscreenDialog: true,
            ),
          ),
          GoRoute(
            name: AppRoute.discovery.name,
            path: 'discovery',
            builder: (context, state) => const DiscoverPage(),
            // pageBuilder: (context, state) => MaterialPage<void>(
            //   key: state.pageKey,
            //   child: const DiscoverPage(),
            //   fullscreenDialog: true,
            // ),
          ),
          GoRoute(
            name: AppRoute.topicPdf.name,
            path: 'topic_pdf/:link',
            pageBuilder: (context, state) {
              final link = state.params['link'] ?? '';
              return MaterialPage<void>(
                key: state.pageKey,
                child: MyPdfViewer(link: link),
                fullscreenDialog: true,
              );
            },
          ),
        ]),
  ],
);
