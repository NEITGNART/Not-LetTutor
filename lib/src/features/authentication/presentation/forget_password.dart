import 'package:beatiful_ui/src/features/authentication/service/auth_functions.dart';
import 'package:beatiful_ui/src/utils/validation_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

import '../../../common_widget/elevated_button.dart';
import '../../../constants/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
              child: const Text(
                'Reset Password',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 6, 40, 18),
              child: const Text(
                'Please enter your account email to receive a reset password link.',
                // style: bodyLarge(context),
                textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 26),
                      width: double.infinity,
                      child: const Text(
                        'Email',
                        // style: bodyLargeBold(context),
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'E.g. email@gmail.com',
                        ),
                        validator: (input) {
                          if (input != null && !input.trim().isValidEmail) {
                            return 'Email must follow standard format';
                          } else {
                            return null;
                          }
                        },
                      )),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: CustomElevatedButton(
                          title: 'Send link',
                          callback: () async {
                            if (_formKey.currentState!.validate()) {
                              final message =
                                  await AuthFunctions.forgetPassword(
                                      nameController.text.trim());
                              Logger().i(message);
                              if (message != null &&
                                  message.statusCode == null) {
                                Get.back();
                                Get.snackbar(
                                  // ignore: use_build_context_synchronously
                                  AppLocalizations.of(context)!
                                      .passwordResetSend, // Title
                                  // ignore: use_build_context_synchronously
                                  AppLocalizations.of(context)!
                                      .passwordResetSendLink, // Message
                                  duration: const Duration(
                                      seconds:
                                          5), // Duration to show the snackbar
                                  snackPosition: SnackPosition
                                      .BOTTOM, // Position of the snackbar on the screen
                                );
                              } else if (message != null &&
                                  (message.statusCode == 401 ||
                                      message.statusCode == 400)) {
                                Get.snackbar(
                                  // ignore: use_build_context_synchronously
                                  AppLocalizations.of(context)!
                                      .passwordResetSend, // Title
                                  message.message!, // Message
                                  duration: const Duration(
                                      seconds:
                                          5), // Duration to show the snackbar
                                  snackPosition: SnackPosition
                                      .BOTTOM, // Position of the snackbar on the screen
                                );
                              } else {
                                Get.snackbar(
                                  // ignore: use_build_context_synchronously
                                  AppLocalizations.of(context)!.error, // Title
                                  // ignore: use_build_context_synchronously
                                  AppLocalizations.of(context)!
                                      .internetError, // Message
                                  duration: const Duration(
                                      seconds:
                                          5), // Duration to show the snackbar
                                  snackPosition: SnackPosition
                                      .BOTTOM, // Position of the snackbar on the screen
                                );
                              }
                            }
                          },
                          buttonType: ButtonType.filledButton,
                          radius: 10),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.dontRememberEmail,
                            // style: bodyLarge(context),
                          ),
                          TextSpan(
                            text:
                                ' ${AppLocalizations.of(context)!.askForHelp}',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.pushNamed(context, MyRouter.login);
                              },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
