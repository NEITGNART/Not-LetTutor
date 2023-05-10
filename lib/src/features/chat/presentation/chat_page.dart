import 'package:beatiful_ui/src/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_sizes.dart';
import '../../tutor/presentation/tutor_home_page.dart';
import 'chat_gpt.dart';

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
                    'Message',
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
                      'Tutor AI chatbot',
                      style: kHeadlineLabelStyle,
                    ),
                    Text(
                      handleOverflow('You: Hello, how can I help you today?'),
                      style: kSubtitleStyle.copyWith(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
            Text(
              '2:22pm',
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
