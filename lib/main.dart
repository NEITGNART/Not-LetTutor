import 'dart:ui';
import 'package:beatiful_ui/src/features/authentication/data/model/user_auth.dart';
import 'package:beatiful_ui/src/features/chat/presentation/chat_page.dart';
import 'package:beatiful_ui/src/features/meeting/presentation/controller/meeting_controller.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/controller/schedule_controller.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/schedule_page.dart';
import 'package:beatiful_ui/src/features/course/discover/representation/discovery_page.dart';
import 'package:beatiful_ui/src/common/presentation/sidebar/presentation/sidebar_screen.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_controller.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';

import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/route/app_route.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

Future<void> main() async {
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
  await Hive.initFlutter();
  Hive.registerAdapter(AuthUserAdapter());
  Get.put(ScheduleController());
  Get.put(TutorController());
  Get.put(DetailTutorController());
  Get.put(MeetingController());
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
        TutorHomePage(),
        DiscoverPage(),
        ChatPage(),
        SchedulePage(),
        // HomePage(),
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
              Icons.home,
              color: Colors.blue,
            ),
            label: 'Letutor',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              label: 'Discovery'),
          NavigationDestination(
              icon: Icon(
                Icons.message_outlined,
                color: Colors.blue,
              ),
              label: 'Messages'),
          NavigationDestination(
              icon: Icon(
                Icons.schedule,
                color: Colors.blue,
              ),
              label: 'Upcoming'),

          // NavigationDestination(
          //     icon: Icon(
          //       Icons.home,
          //       color: Colors.blue,
          //     ),
          //     label: 'Home'),

          NavigationDestination(
            icon: Icon(
              Icons.settings,
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
