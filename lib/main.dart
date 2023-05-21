import 'dart:io';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
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

Future<void> launchUrlAsync(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) throw 'Could not launch $url';
}

class LocalController extends GetxController {
  Rx<Locale> locale = Rx<Locale>(const Locale('en', 'US'));
  @override
  Future<void> onInit() async {
    super.onInit();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('languageCode');
    final String? countryCode = prefs.getString('countryCode');
    if (countryCode != null && languageCode != null) {
      locale.value = Locale(languageCode, countryCode);
    }
  }

  Future<void> changeLocale(Locale locale) async {
    this.locale.value = locale;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    final message = FirebaseMessaging.instance;

    if (Platform.isIOS) {
      await message.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    message.subscribeToTopic('all_users');
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (Platform.isIOS) {
          if (message.data['iosUrl'] != null) {
            Get.snackbar(
              message.notification?.title ?? '',
              message.notification?.body ?? '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              margin: const EdgeInsets.all(10),
              borderRadius: 10,
              duration: const Duration(seconds: 10),
              onTap: (snack) {
                launchUrlAsync(
                  Uri.parse(
                    '${message.data['iosUrl']}}',
                  ),
                );
              },
            );
          }
        } else {
          if (message.data['androidUrl'] != null) {
            Get.snackbar(
              message.notification?.title ?? '',
              message.notification?.body ?? '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              margin: const EdgeInsets.all(10),
              borderRadius: 10,
              duration: const Duration(seconds: 10),
              onTap: (snack) {
                launchUrlAsync(
                  Uri.parse(
                    '${message.data['androidUrl']}}',
                  ),
                );
              },
            );
          } else if (message.data['url'] != null) {
            Get.snackbar(
              message.notification?.title ?? '',
              message.notification?.body ?? '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              margin: const EdgeInsets.all(10),
              borderRadius: 10,
              duration: const Duration(seconds: 10),
              onTap: (snack) {
                launchUrlAsync(
                  Uri.parse(
                    '${message.data['androidUrl']}}',
                  ),
                );
              },
            );
          }
        }
      },
    );
    // // get token
    // FirebaseMessaging.instance.getToken().then((token) {
    //   Logger().e('token $token');
    // });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        // Logger().e('A new onMessageOpenedApp event was published!');
        if (Platform.isIOS) {
          if (message.data['iosUrl'] != null) {
            launchUrl(
              Uri.parse(
                '${message.data['iosUrl']}}',
              ),
            );
          }
        } else {
          if (message.data['androidUrl'] != null) {
            launchUrlAsync(
              Uri.parse(
                '${message.data['androidUrl']}}',
              ),
            );
          } else if (message.data['url'] != null) {
            launchUrlAsync(
              Uri.parse(
                '${message.data['url']}}',
              ),
            );
          }
        }
      },
    );
  } catch (e) {
    Logger().e(e);
  }

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
}

// runApp(const ChewieDemo());

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
        destinations: [
          NavigationDestination(
            icon: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
              icon: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
              label: AppLocalizations.of(context)!.discovery),
          NavigationDestination(
              icon: const Icon(
                Icons.message_outlined,
                color: Colors.blue,
              ),
              label: AppLocalizations.of(context)!.messages),
          NavigationDestination(
              icon: const Icon(
                Icons.schedule,
                color: Colors.blue,
              ),
              label: AppLocalizations.of(context)!.upcomming),

          // NavigationDestination(
          //     icon: Icon(
          //       Icons.home,
          //       color: Colors.blue,
          //     ),
          //     label: 'Home'),

          NavigationDestination(
            icon: const Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            label: AppLocalizations.of(context)!.setting,
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
