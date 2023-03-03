import 'package:beatiful_ui/common/presentation/app_bar.dart';
import 'package:flutter/material.dart';

import '../../common/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          // min
          mainAxisSize: MainAxisSize.min,
          children: [
            const MyAppBar(),
            Flexible(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (MediaQuery.of(context).size.width > 800) ...[
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // boder radius
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                      // color grey
                                    ),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: const LoginForm())),
                          Flexible(
                            child: Image.network(
                                fit: BoxFit.cover,
                                'https://sandbox.app.lettutor.com/static/media/login.8d01124a.png'),
                          )
                        ],
                      ),
                    ] else ...[
                      Image.network(
                          // height and width
                          // fit image
                          height: MediaQuery.of(context).size.height * 0.35,
                          fit: BoxFit.cover,
                          'https://sandbox.app.lettutor.com/static/media/login.8d01124a.png'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container(child: const LoginForm())),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
