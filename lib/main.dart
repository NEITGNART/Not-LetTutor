import 'dart:io';
import 'dart:ui';
import 'package:beatiful_ui/src/app.dart';
import 'package:beatiful_ui/src/features/authentication/data/model/user_auth.dart';
import 'package:beatiful_ui/src/features/authentication/presentation/controller/login_controller.dart';
import 'package:beatiful_ui/src/features/localization/presentation/controller/locale_controller.dart';
import 'package:beatiful_ui/src/features/meeting/presentation/controller/meeting_controller.dart';
import 'package:beatiful_ui/src/features/schedule/history/presentation/controller/history_controller.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/controller/schedule_controller.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_controller.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';
import 'package:beatiful_ui/src/utils/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    registerErrorHandlers();
    await registerRemoteNotiHandler();
  } catch (e) {
    Logger().e(e);
  }
  await initApp();
  runApp(const MyApp());
}

Future<void> registerRemoteNotiHandler() async {
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
    handleOpenInAppNoti,
  );
  FirebaseMessaging.onMessageOpenedApp.listen(
    handleOpenFromNoti,
  );
}

void registerErrorHandlers() {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> initApp() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(AuthUserAdapter());
  // Initialize GetX
  Get.put(LocaleController());
  Get.put(LoginPageController());
  Get.put(ScheduleController());
  Get.put(TutorController());
  Get.put(HistoryController());
  Get.put(DetailTutorController());
  Get.put(MeetingController());
}
