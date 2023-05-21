import 'package:beatiful_ui/src/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../common/app_sizes.dart';
import '../../../utils/validate_email.dart';
import '../data/model/user.dart';
import '../service/auth_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LetTutor")),
      body: const RegisterBody(),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  late String message = '';
  late bool isSuccess = false;
  late GoogleSignIn googleSignIn;

  void handleSignInGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;

      if (accessToken != null) {
        final response =
            await AuthFunctions.loginWithGoogle(accessToken, () {});
        if (response['isSuccess'] == false) {
          setState(() {
            isSuccess = response['isSuccess'] as bool;
            message = response['message'] as String;
          });
        } else {
          if (!mounted) return;
          context.goNamed(AppRoute.home.name);
        }
      }
    } catch (e) {
      setState(() {
        isSuccess = false;
        message = e.toString();
      });
    }
  }

  void handleSingInFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final String accessToken = result.accessToken!.token;
        final response =
            await AuthFunctions.loginWithFacebook(accessToken, () {});
        if (response['isSuccess'] == false) {
          setState(() {
            isSuccess = response['isSuccess'] as bool;
            message = response['message'] as String;
          });
        } else {
          if (!mounted) return;
          context.goNamed(AppRoute.home.name);
        }
      } else {
        setState(() {
          isSuccess = false;
          message = result.message!;
        });
      }
    } catch (e) {
      setState(() {
        isSuccess = false;
        message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repasswordController = TextEditingController();
    googleSignIn = GoogleSignIn();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          gapH64,
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                AppLocalizations.of(context)!.becomeMember,
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'E.g. email@gmail.com'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.password,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextField(
              obscureText: true,
              controller: repasswordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.confirmPassword,
              ),
            ),
          ),
          message != ''
              ? Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style:
                        TextStyle(color: isSuccess ? Colors.green : Colors.red),
                  ),
                )
              : Container(),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text(AppLocalizations.of(context)!.signUp),
              onPressed: () async {
                if (nameController.text == '' ||
                    passwordController.text == '' ||
                    repasswordController.text == '') {
                  setState(() {
                    isSuccess = false;
                    message = AppLocalizations.of(context)!.emptyField;
                  });
                } else if (!validateEmail(nameController.text)) {
                  setState(() {
                    isSuccess = false;
                    message = AppLocalizations.of(context)!.invalidEmail;
                  });
                } else if (passwordController.text.length < 6) {
                  setState(() {
                    isSuccess = false;
                    message = AppLocalizations.of(context)!.passwordTooShort;
                  });
                } else if (repasswordController.text !=
                    passwordController.text) {
                  setState(() {
                    isSuccess = false;
                    message = AppLocalizations.of(context)!.errPasswordMismatch;
                  });
                } else {
                  var response = await AuthFunctions.register(
                      User(nameController.text, passwordController.text));
                  setState(() {
                    isSuccess = response['isSuccess'] as bool;
                    message = isSuccess
                        ? AppLocalizations.of(context)!.registerSuccess
                        : response['message'] as String;
                  });
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            alignment: Alignment.center,
            child: const Center(
              child: Column(
                children: [
                  // Text('Or continue with'),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         handleSingInFacebook();
                  //       },
                  //       child: SvgPicture.network(
                  //           'https://sandbox.app.lettutor.com/static/media/facebook-logo.3bac8064.svg',
                  //           width: 40),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     GestureDetector(
                  //       onTap: () {
                  //         handleSignInGoogle();
                  //       },
                  //       child: SvgPicture.network(
                  //           'https://sandbox.app.lettutor.com/static/media/google-logo.5f53496e.svg',
                  //           width: 40),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Container(
                  //       width: 40,
                  //       height: 40,
                  //       padding: const EdgeInsets.all(3),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         border: Border.all(
                  //             color: const Color.fromARGB(240, 7, 149, 243),
                  //             width: 1.5),
                  //       ),
                  //       child: SvgPicture.asset(
                  //         'asset/icons/iphonex.svg',
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  // GestureDetector(
                  //   onTap: () {
                  //     context.goNamed(AppRoute.signUp.name);
                  //   },
                  //   child: RichText(
                  //     text: TextSpan(children: [
                  //       TextSpan(
                  //           text: 'Not a member yet?',
                  //           style: kSubtitleStyle.copyWith(
                  //             color: Colors.black,
                  //           )),
                  //       TextSpan(
                  //           text: ' Sign up',
                  //           style: kSubtitleStyle.copyWith(
                  //               color: const Color.fromARGB(255, 2, 138, 249)))
                  //     ]),
                  //   ),
                  // )
                ],
              ),
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
            //     ElevatedButton(
            //         onPressed: () {
            //           handleSingInFacebook();
            //         },
            //         style: ElevatedButton.styleFrom(
            //             shape: const CircleBorder(
            //                 side:
            //                     BorderSide(width: 1, color: Color(0xff007CFF))),
            //             backgroundColor: Colors.white,
            //             padding: const EdgeInsets.all(5)),
            //         child: SvgPicture.asset("asset/svg/ic_facebook.svg",
            //             width: 30, height: 30, color: const Color(0xff007CFF))),
            //     ElevatedButton(
            //         onPressed: () {
            //           handleSignInGoogle();
            //         },
            //         style: ElevatedButton.styleFrom(
            //             shape: const CircleBorder(
            //                 side:
            //                     BorderSide(width: 1, color: Color(0xff007CFF))),
            //             backgroundColor: Colors.white,
            //             padding: const EdgeInsets.all(5)),
            //         child: SvgPicture.asset("asset/svg/ic_google.svg",
            //             width: 30, height: 30)),
            //   ],
            // ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.loginQuestion),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
