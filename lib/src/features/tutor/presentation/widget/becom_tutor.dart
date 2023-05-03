import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BecomeTutor extends StatelessWidget {
  const BecomeTutor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a tutor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'asset/svg/smile.svg',
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
            gapH24,
            const Text(
              "You have done all the steps.Please, wait for the operator's approval",
            )
          ],
        ),
      ),
    );
  }
}
