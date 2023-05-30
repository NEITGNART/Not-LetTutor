import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                      style: TextStyle(
                          color: isSuccess ? Colors.green : Colors.red),
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
                      message =
                          AppLocalizations.of(context)!.errPasswordMismatch;
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
                    SizedBox(height: 10),
                  ],
                ),
              ),
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
      ),
    );
  }
}
