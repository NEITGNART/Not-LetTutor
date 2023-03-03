import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
              const SizedBox(height: 10),
              Container(
                child: Text(
                    'Become fluent faster through one on one video chat lessons tailored to your goals.',
                    style: kCalloutLabelStyle),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text('EMAIL', style: kSubtitleStyle),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // radius: 10,
              labelText: 'Enter your email...',
            ),
          ),
          const SizedBox(height: 10),
          Text('PASSWORD', style: kSubtitleStyle),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // radius: 10,
              labelText: 'Enter your password...',
              //
              // suffixIcon: const IconButton(onPressed: () {
              // }, icon: Icon(Icons.visibility)),

              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  // TODO: show password
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Text('Forgot Password?', style: kSubtitleStyle),
          // link text
          TextButton(
              child: Text('Forgot Password?',
                  style: kSubtitleStyle.copyWith(
                    color: Colors.blue,
                  )),
              onPressed: () {}),
          const SizedBox(height: 10),
          Row(children: [
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
                onPressed: () {},
                child: Text('LOG IN',
                    style: kTitle1Style.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                const Text('Or continue with'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.network(
                        'https://sandbox.app.lettutor.com/static/media/facebook-logo.3bac8064.svg',
                        width: 40),
                    const SizedBox(width: 10),
                    SvgPicture.network(
                        'https://sandbox.app.lettutor.com/static/media/google-logo.5f53496e.svg',
                        width: 40),
                    const SizedBox(width: 10),
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color.fromARGB(240, 7, 149, 243),
                            width: 1.5),
                      ),
                      child: SvgPicture.asset(
                        'asset/icons/iphonex.svg',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RichText(
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
                )
              ],
            ),
          )
        ]);
  }
}
