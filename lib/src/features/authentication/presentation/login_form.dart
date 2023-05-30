import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/constants.dart';
import '../../../route/app_route.dart';
import '../data/model/user.dart';
import 'controller/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginPageController c = Get.find();
  TextEditingController userController =
      TextEditingController(text: 'student@lettutor.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  // TextEditingController userController =
  //     TextEditingController(text: 'phhai@gmail.com');
  // TextEditingController passwordController =
  //     TextEditingController(text: '123456');

  bool isPasswordVisible = false;

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: MediaQuery.of(context).size.width >= 800
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text(
              'Say hello to your English tutors'.tr,
              style: kTitle1Style.copyWith(color: Colors.blue, fontSize: 30),
            ),
            gapH12,
          ],
        ),

        const SizedBox(height: 10),
        Text('EMAIL', style: kSubtitleStyle),
        const SizedBox(height: 10),
        TextField(
            controller: userController,
            decoration: InputDecoration(
              fillColor: Colors.blueGrey.shade50,
              filled: true,
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              hintText: 'Username',
            )
            // radius: 10,
            ),
        const SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.password, style: kSubtitleStyle),
        const SizedBox(height: 10),
        TextField(
            controller: passwordController,
            // password
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              fillColor: Colors.blueGrey.shade50,
              filled: true,
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              hintText: AppLocalizations.of(context)!.password,
            )),
        const SizedBox(height: 10),
        // Text('Forgot Password?', style: kSubtitleStyle),
        // link text

        Obx(() {
          if (!c.isSuccess.value && c.message.value.isNotEmpty) {
            return Text('Login failed: ${c.message}',
                style: const TextStyle(color: Colors.red));
          }
          return const SizedBox();
        }),

        TextButton(
            child: Text(
              AppLocalizations.of(context)!.forgotPassword,
              style: kSubtitleStyle.copyWith(
                color: Colors.blue,
              ),
            ),
            onPressed: () {
              context.goNamed(AppRoute.forgotPassword.name);
            }),
        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                // set height
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  // set color
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  final email = userController.text;
                  final password = passwordController.text;
                  c.handleSignIn(context, User(email, password));
                  // context.goNamed(AppRoute.discovery.name);
                },
                child: Obx(() {
                  if (c.isLoading.value) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  return Text(AppLocalizations.of(context)!.login,
                      style: kTitle1Style.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ));
                }),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        Center(
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.orContinueWith),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      c.handleSignInFacebook(
                        context,
                      );
                    },
                    child: SvgPicture.network(
                        'https://sandbox.app.lettutor.com/static/media/facebook-logo.3bac8064.svg',
                        width: 40),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      c.handleSignInGoogle(context);
                    },
                    child: SvgPicture.network(
                        'https://sandbox.app.lettutor.com/static/media/google-logo.5f53496e.svg',
                        width: 40),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.signUp.name);
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!.notMember,
                        style: kSubtitleStyle.copyWith(
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: ' ${AppLocalizations.of(context)!.signUp}',
                        style: kSubtitleStyle.copyWith(
                            color: const Color.fromARGB(255, 2, 138, 249)))
                  ]),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
