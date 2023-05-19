import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../main.dart';
import '../data/model/user_auth.dart';
import 'controller/login_controller.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    LoginPageController c = Get.find();
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            final auth = snapshot.data as AuthUser;
            c.refreshAuth(context, auth);
            return const HomePage();
          }
          Logger().i(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const LoginPage();
      },
      future: c.init(),
    );
  }
}
