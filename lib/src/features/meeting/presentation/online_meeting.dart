import 'package:beatiful_ui/src/common/constants.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../tutor/model/booking_info.dart';
import 'controller/meeting_controller.dart';

String getFirstLetterName(String name) {
  final firstLetter = name.split(' ').map((e) => e[0].toUpperCase());
  return firstLetter.join();
}

class MeetingPage extends StatelessWidget {
  final String? callUrl;
  final BookingInfo booking;
  const MeetingPage({super.key, this.callUrl, required this.booking});
  @override
  Widget build(BuildContext context) {
    MeetingController c = Get.find();
    c.init(booking);
    return SafeArea(
      child: Container(
          color: Colors.grey,
          child: Stack(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade300,
                      radius: 130,
                      child: Text(
                        getFirstLetterName(booking.scheduleDetailInfo
                                ?.scheduleInfo?.tutorInfo!.name ??
                            'Pham Tien'),
                        style: const TextStyle(fontSize: 100),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Obx(
                        () {
                          if (c.countDown.value == "00:00:00") {
                            return Text(
                              'Lesson is starting',
                              style: kCalloutLabelStyle.copyWith(
                                  color: Colors.white),
                            );
                          }
                          return Text(
                            '${c.countDown.value} until lesson start\n(${c.formatDate.value}) ',
                            style: kCalloutLabelStyle.copyWith(
                                color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 20),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(getAvatar(booking
                          .scheduleDetailInfo
                          ?.scheduleInfo
                          ?.tutorInfo!
                          .avatar)),
                    ),
                  ),
                ),
              ),

              // ElevatedButton(
              //     onPressed: () {
              //       joinMeeting(booking);
              //     },
              //     child: const Text('Let go'))

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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Container(
              //     margin: const EdgeInsets.only(bottom: 10, right: 10),
              //     child: const CircleAvatar(
              //       radius: 30,
              //       // https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4
              //       backgroundImage: NetworkImage(
              //           'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4'),
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
