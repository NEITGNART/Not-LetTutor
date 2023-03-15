import 'package:beatiful_ui/src/common/constants.dart';
import 'package:flutter/material.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Stack(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 100,
                    child: Text('DT', style: TextStyle(fontSize: 100)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                        'Fri, 30 Sep 22 18:20 - 18:55 until lesson start',
                        style:
                            kCalloutLabelStyle.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: const CircleAvatar(
                  radius: 30,
                  // https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // create iconbutton mic, record, share, chat, raise hand, fullscreen, more, end call. With end call is red otherwise is black
                    IconButton(
                      icon: const Icon(Icons.mic_none_outlined,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam_outlined,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam_off_outlined,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.back_hand_outlined,
                          color: Colors.white),
                      onPressed: () {},
                    ),

                    IconButton(
                      icon: const Icon(Icons.fullscreen_outlined,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz_outlined,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.call_end, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 10),
                child: const CircleAvatar(
                  radius: 30,
                  // https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4'),
                ),
              ),
            )
          ],
        ));
  }
}
