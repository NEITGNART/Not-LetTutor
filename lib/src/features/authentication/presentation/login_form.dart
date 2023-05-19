import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../common/constants.dart';
import '../../../route/app_route.dart';
import '../data/model/user.dart';
import 'controller/login_controller.dart';

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
              'Say hello to your English tutors',
              style: kTitle1Style.copyWith(color: Colors.blue, fontSize: 30),
            ),
            gapH12,
            // Container(
            //   child: Text(
            //       'Become fluent faster through one on one video chat lessons tailored to your goals.',
            //       style: kCalloutLabelStyle),
            // ),
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
              hintText: 'Enter name, country',
            )
            // radius: 10,
            ),
        const SizedBox(height: 10),
        Text('PASSWORD', style: kSubtitleStyle),
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
              hintText: 'Enter name, country',
            )),
        const SizedBox(height: 10),
        // Text('Forgot Password?', style: kSubtitleStyle),
        // link text

        Obx(() {
          Logger().e(c.message);
          if (!c.isSuccess.value && c.message.value.isNotEmpty) {
            return Text('Login failed: ${c.message}',
                style: const TextStyle(color: Colors.red));
          }
          return const SizedBox();
        }),

        TextButton(
            child: Text(
              'Forgot Password?',
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
                  return Text('LOG IN',
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
              const Text('Or continue with'),
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
                  context.goNamed(AppRoute.signUp.name);
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Not a member yet?',
                        style: kSubtitleStyle.copyWith(
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: ' Sign up',
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
