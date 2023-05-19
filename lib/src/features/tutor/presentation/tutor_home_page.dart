import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/common/constants.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/widget/tutor_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../common/presentation/my_filter.dart';
import 'widget/up_coming_lesson.dart';
import '../../../utils/countries_list.dart';
import '../model/tutor.dart';
import 'controller/tutor_controller.dart';

var logger = Logger();

String getCountry(String? country) {
  return country != null
      ? countryList[country] != null
          ? countryList[country]!
          : country
      : '';
}

String getAvatar(String? avatar) {
  const errorUrl =
      "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png";
  const fallbackUrl =
      "https://lh3.googleusercontent.com/a/AGNmyxYXM6_Y1arArTV3OlHJ-QZaY5M3hInrQHTYLvtVGg=s192-c-rg-br100";
  String? avatarUrl =
      avatar != null && avatar == errorUrl ? fallbackUrl : avatar;
  return avatarUrl ??
      "https://lh3.googleusercontent.com/a/AGNmyxYXM6_Y1arArTV3OlHJ-QZaY5M3hInrQHTYLvtVGg=s192-c-rg-br100";
}

class TutorHomePage extends StatelessWidget {
  const TutorHomePage({super.key});

  static final List<Tutor> tutors = [];

  // init

  @override
  Widget build(BuildContext context) {
    // Init Tutor controller
    final TutorController tutorC = Get.find();
    tutorC.init();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: tutorC.scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const MyAppBar(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => UpComingLesson(
                        isUpComingLesson: tutorC.nextClass.value != null,
                        totalLessonTime: tutorC.hoursTotal.value,
                        formatDate: tutorC.formatDate.value,
                        countDown: tutorC.countDown.value,
                        cb: () {},
                      ),
                    ),
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyFilter(),
                          // const Divider(
                          //   color: Colors.grey,
                          //   thickness: 1,
                          // ),
                          Text('Recommended Tutors', style: kTitle1Style),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            if (tutorC.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (tutorC.tutorList.isEmpty) {
                              return Column(
                                children: [
                                  SvgPicture.asset(
                                    "asset/svg/ic_notfound.svg",
                                    width: 200,
                                  ),
                                  const Center(
                                    child: Text('No tutor found'),
                                  ),
                                ],
                              );
                            }
                            if (tutorC.tutorList.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: tutorC.tutorList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MyTutorCardReview(
                                    tutor: tutorC.tutorList[index],
                                  );
                                },
                              );
                              // return Column(
                              //   children: [
                              //     ...tutorC.tutorList.map(
                              //       (e) => MyTutorCardReview(
                              //         tutor: e,
                              //       ),
                              //     )
                              //   ],
                              // );
                            } else {
                              return const Center(
                                child: Text('No tutor found'),
                              );
                            }
                          }),
                          Obx(() {
                            return Visibility(
                              visible: tutorC.isLoadMore.value,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            // if (tutorC.isLoadMore.value) {
                            //   Logger().i('isLoadMore');
                            //   return const Text('asdf');
                            //   // return const Center(
                            //   //   child: CircularProgressIndicator(),
                            //   // );
                            // }
                            // return const SizedBox();
                          }),
                          gapH32,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
