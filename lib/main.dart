import 'dart:ui';
import 'package:beatiful_ui/src/features/authentication/presentation/login_page.dart';
import 'package:beatiful_ui/src/features/booking/presentation/schedule_page.dart';
import 'package:beatiful_ui/src/features/course/details/presentation/lesson_detail_page.dart';
import 'package:beatiful_ui/src/features/course/discover/representation/discovery_page.dart';
import 'package:beatiful_ui/src/features/history/presentation/history_page.dart';
import 'package:beatiful_ui/src/common/presentation/sidebar/presentation/sidebar_screen.dart';
import 'package:beatiful_ui/src/features/meeting/presentation/online_meeting.dart';

import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/features/tutor/presentation/tutor_detail_page.dart';
import 'src/features/course/details/temp/presentation/home.dart';
import 'src/route/app_route.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

void main() {
  // EasyLoading.instance
  //   ..displayDuration = const Duration(milliseconds: 2000)
  //   ..indicatorType = EasyLoadingIndicatorType.cubeGrid
  //   ..maskType = EasyLoadingMaskType.clear
  //   ..loadingStyle = EasyLoadingStyle.custom
  //   ..textColor = Colors.black
  //   ..animationStyle = EasyLoadingAnimationStyle.scale
  //   ..indicatorSize = 45.0
  //   ..radius = 10.0
  //   ..backgroundColor = Color.fromARGB(255, 7, 199, 238)
  //   ..indicatorColor = Colors.white
  //   ..userInteractions = false;
  runApp(const ProviderScope(child: MyApp()));
  // runApp(const ChewieDemo());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final goRouter = configRouter;

    return MaterialApp.router(
      scrollBehavior: AppScrollBehavior().copyWith(scrollbars: false),
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Page'),
      // ),
      body: const [
        MeetingPage(),
        LessonDetailScreen(),
        DiscoverPage(),
        HistoryPage(),
        SchedulePage(),
        TutorDetailPage(),
        HomePage(),
        LoginPage(),
        TutorHomePage(),
        SideBarScreen(),
      ][_currentPageIndex],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.meeting_room_outlined,
                color: Colors.blue,
              ),
              label: 'Meetings'),
          NavigationDestination(
              icon: Icon(
                Icons.meeting_room_outlined,
                color: Colors.blue,
              ),
              label: 'Lesson'),
          NavigationDestination(
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              label: 'Discovery'),
          NavigationDestination(
              icon: Icon(
                Icons.phone,
                color: Colors.blue,
              ),
              label: 'History'),
          NavigationDestination(
              icon: Icon(
                Icons.schedule,
                color: Colors.blue,
              ),
              label: 'Schedule'),
          NavigationDestination(
              icon: Icon(
                Icons.details,
                color: Colors.blue,
              ),
              label: 'Tutor details'),
          NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              label: 'Home'),
          NavigationDestination(
            icon: Icon(
              Icons.chat,
              color: Colors.blue,
            ),
            label: 'Login',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.people,
              color: Colors.blue,
            ),
            label: 'TutorList',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            label: 'Settings',
          ),
        ],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
