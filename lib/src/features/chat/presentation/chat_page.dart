import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/constants.dart';
import '../../tutor/presentation/tutor_home_page.dart';
import 'chat_gpt.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.message,
                    style: kTitle1Style.copyWith(fontSize: 17),
                  )
                ],
              ),
              gapH16,
              const AIChatCard()
            ],
          ),
        ),
      ),
    );
  }
}

class AIChatCard extends StatelessWidget {
  const AIChatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const AICHATBOT());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(getAvatar(null)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                gapW12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tutorChatBot,
                      style: kHeadlineLabelStyle,
                    ),
                    Text(
                      handleOverflow(AppLocalizations.of(context)!.botContent),
                      style: kSubtitleStyle.copyWith(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
            Text(
              'now',
              style: kSubtitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}

String handleOverflow(String message) {
  return message.length > 15 ? '${message.substring(0, 15)}...' : message;
}

String handleCountryOverflow(String message) {
  return message.length > 10 ? '${message.substring(0, 10)}...' : message;
}
