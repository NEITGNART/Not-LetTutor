import 'package:beatiful_ui/src/features/authentication/presentation/loading_page.dart';
import 'package:beatiful_ui/src/features/authentication/presentation/login_page.dart';
import 'package:beatiful_ui/src/features/course/details/presentation/course_detail_page.dart';
import 'package:beatiful_ui/src/features/course/discover/representation/discovery_page.dart';
import 'package:beatiful_ui/src/features/meeting/presentation/online_meeting.dart';
import 'package:beatiful_ui/src/features/profile/presentation/profile_page.dart';
import 'package:beatiful_ui/src/features/tutor/model/booking_info.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../features/authentication/presentation/forget_password.dart';
import '../features/authentication/presentation/register.dart';
import '../features/course/details/presentation/detail_lesson_page.dart';
import '../features/course/discover/model/course.dart';
import '../features/schedule/history/presentation/history_page.dart';
import '../features/tutor/presentation/home_page.dart';
import '../features/tutor/presentation/review_page.dart';

enum AppRoute {
  detailCourse,
  home,
  discovery,
  topicPdf,
  courseDiscovery,
  tutorDetail,
  meeting,
  signUp,
  logIn,
  forgotPassword,
  profile,
  review,
  history,
  signOut,
}

final configRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: Get.key,
  // debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.logIn.name,
      builder: (context, state) {
        return const SplashScreen();
      },
      routes: [
        GoRoute(
          path: 'sign_out',
          name: AppRoute.signOut.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const LoginPage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          path: 'profile',
          name: AppRoute.profile.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const ProfilePage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          name: AppRoute.detailCourse.name,
          path: 'detail_course/:courseId',
          pageBuilder: (context, state) {
            final courseId = state.params['courseId'] ?? '';
            return MaterialPage<void>(
              key: state.pageKey,
              child: DetailCourseScreen(
                courseId: courseId,
                course: state.extra as Course,
              ),
              fullscreenDialog: true,
            );
          },
        ),
        GoRoute(
          name: AppRoute.review.name,
          path: 'review/:tutorId',
          pageBuilder: (context, state) {
            final tutorId = state.params['tutorId'] ?? '';
            return MaterialPage<void>(
              key: state.pageKey,
              child: ReviewPage(
                tutorId: tutorId,
              ),
              fullscreenDialog: true,
            );
          },
        ),
        GoRoute(
          name: AppRoute.tutorDetail.name,
          path: 'tutor_detail/:id',
          pageBuilder: (context, state) {
            final tutorId = state.params['id'] ?? '';
            return MaterialPage<void>(
              key: state.pageKey,
              child: TutorDetailPage(
                tutorId: tutorId,
              ),
              fullscreenDialog: true,
            );
          },
        ),
        GoRoute(
          name: AppRoute.meeting.name,
          path: 'meeting/:id',
          pageBuilder: (context, state) {
            final meetingId = state.params['id'] ?? '';
            final BookingInfo booking = state.extra as BookingInfo;
            return MaterialPage<void>(
              key: state.pageKey,
              child: MeetingPage(
                callUrl: meetingId,
                booking: booking,
              ),
              fullscreenDialog: true,
            );
          },
        ),
        GoRoute(
          name: AppRoute.courseDiscovery.name,
          path: 'discovery_course',
          pageBuilder: (context, state) {
            final Course course = state.extra as Course;
            return MaterialPage<void>(
              key: state.pageKey,
              child: DetailLessonPage(
                course: course,
              ),
              fullscreenDialog: true,
            );
          },
        ),
        GoRoute(
          path: 'home',
          name: AppRoute.home.name,
          builder: (context, state) => const HomePage(),
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
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const DiscoverPage(),
            fullscreenDialog: true,
          ),
        ),
        GoRoute(
          name: AppRoute.history.name,
          path: 'history',
          builder: (context, state) => const DiscoverPage(),
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const HistoryPage(),
            fullscreenDialog: true,
          ),
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
        GoRoute(
          name: AppRoute.signUp.name,
          path: 'sign_up',
          pageBuilder: (context, state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: const RegisterScreen(),
              fullscreenDialog: true,
            );
          },
        ),
        GoRoute(
          name: AppRoute.forgotPassword.name,
          path: 'forgot_password',
          pageBuilder: (context, state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: const ForgotPasswordPage(),
              fullscreenDialog: true,
            );
          },
        ),
      ],
    ),
  ],
);
