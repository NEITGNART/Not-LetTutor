import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/schedule_page.dart';
import 'package:flutter/material.dart';

class InteractiveTab extends StatelessWidget {
  const InteractiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        children: [
          gapH16,
          MyEmptyResult(text: "No data"),
        ],
      ),
    );
  }
}
