import 'package:beatiful_ui/src/features/localization/presentation/controller/locale_controller.dart';
import 'package:beatiful_ui/src/route/app_route.dart';
import 'package:beatiful_ui/src/utils/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController c = Get.find();
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
