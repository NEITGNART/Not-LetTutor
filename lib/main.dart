import 'dart:ui';
import 'package:beatiful_ui/src/features/authentication/data/model/user_auth.dart';
import 'package:beatiful_ui/src/features/authentication/presentation/controller/login_controller.dart';
import 'package:beatiful_ui/src/features/chat/presentation/chat_page.dart';
import 'package:beatiful_ui/src/features/meeting/presentation/controller/meeting_controller.dart';
import 'package:beatiful_ui/src/features/schedule/history/presentation/controller/history_controller.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/controller/schedule_controller.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/schedule_page.dart';
import 'package:beatiful_ui/src/features/course/discover/representation/discovery_page.dart';
import 'package:beatiful_ui/src/common/presentation/sidebar/presentation/sidebar_screen.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_controller.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';

import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/route/app_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class LocalController extends GetxController {
  var locale = const Locale('en', 'US').obs;
  void changeLocale(Locale locale) {
    this.locale.value = locale;
  }
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

//   import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
  await Hive.initFlutter();
  Hive.registerAdapter(AuthUserAdapter());
  Get.put(LocalController());
  Get.put(LoginPageController());
  Get.put(ScheduleController());
  Get.put(TutorController());
  Get.put(HistoryController());
  Get.put(DetailTutorController());
  Get.put(MeetingController());
  runApp(const MyApp());
  // runApp(const ChewieDemo());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalController c = Get.find();
    final goRouter = configRouter;
    return Obx(() => MaterialApp.router(
          scrollBehavior: AppScrollBehavior().copyWith(scrollbars: false),
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: EasyLoading.init(),
          locale: c.locale.value,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPageIndex = 0;

  @override
  void initState() {
    // LoginPageController c = Get.find();
    // c.refreshAuth(context, c.auth);
    super.initState();
  }

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
