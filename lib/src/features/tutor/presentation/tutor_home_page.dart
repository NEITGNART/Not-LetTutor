import 'package:beatiful_ui/src/common/constants.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/widget/detail_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../common/presentation/app_bar.dart';
import '../../../common/presentation/my_filter.dart';
import '../../../utils/learning_topics.dart';
import 'widget/up_coming_lesson.dart';
import '../../../route/app_route.dart';
import '../../../utils/countries_list.dart';
import '../model/tutor.dart';
import 'controller/tutor_controller.dart';

var fruits = ['Apple', 'Banana', 'Mango', 'Orange'];

// All
// English for kids
// English for Business
// Conversational
// STARTERS
// MOVERS
// FLYERS
// KET
// PET
// IELTS
// TOEFL
// TOEIC

var logger = Logger();

class TutorHomePage extends StatelessWidget {
  const TutorHomePage({super.key});

  static final List<Tutor> tutors = [];

  @override
  Widget build(BuildContext context) {
    // Init Tutor controller
    final tutorController = Get.put(TutorController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyAppBar(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const UpComingLesson(),
                    Container(
                      padding: const EdgeInsets.all(30),
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
                            if (tutorController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (tutorController.tutorList.isEmpty) {
                              return const Center(
                                child: Text('No tutor found'),
                              );
                            }

                            if (tutorController.tutorList.isNotEmpty) {
                              return Column(
                                children: [
                                  ...tutorController.tutorList.map(
                                    (e) => MyTutorCardReview(
                                      tutor: e,
                                    ),
                                  )
                                ],
                              );
                            }

                            return const Text('Error');
                            // return Column(children: [
                            //   ...tutorController.tutorList.map(
                            //     (e) => MyTutorCardReview(
                            //       tutor: e,
                            //     ),
                            //   )
                            // ]);
                          }),

                          // Expanded(
                          //   child: Container(
                          //     margin: const EdgeInsets.only(top: 24),
                          //     child: ListView.builder(
                          //       itemCount: 2,
                          //       itemBuilder:
                          //           (BuildContext context, int index) =>
                          //               ListTile(
                          //         title: Text("List Item ${index + 1}"),
                          //       ),
                          //     ),
                          //   ),
                          // ),
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

class MyTutorCardReview extends StatelessWidget {
  const MyTutorCardReview({
    Key? key,
    required this.tutor,
  }) : super(key: key);
  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    const errorUrl =
        "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png";
    const fallbackUrl =
        "https://lh3.googleusercontent.com/a/AGNmyxYXM6_Y1arArTV3OlHJ-QZaY5M3hInrQHTYLvtVGg=s192-c-rg-br100";
    final String? avatarUrl = tutor.avatar != null && tutor.avatar == errorUrl
        ? fallbackUrl
        : tutor.avatar;

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoute.tutorDetail.name,
          params: {
            'id': tutor.userId,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(avatarUrl ??
                          "https://lh3.googleusercontent.com/a/AGNmyxYXM6_Y1arArTV3OlHJ-QZaY5M3hInrQHTYLvtVGg=s192-c-rg-br100")),
                  const SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tutor.name ?? "",
                        style: kHeadlineLabelStyle,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          SvgPicture.network(
                            'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${"vn"}.svg',
                            width: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                              tutor.country != null
                                  ? countryList[tutor.country] != null
                                      ? countryList[tutor.country]!
                                      : tutor.country!
                                  : '',
                              style: kSearchPlaceholderStyle),
                          const SizedBox(width: 5.0),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      tutor.rating != null
                          ? getStarsWidget(5, tutor.rating!.floor())
                          : Text('No rating', style: kSearchPlaceholderStyle),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: tutor.isFavorite ?? false
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.blue,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            // make row scrollable by horizontal

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tutor.specialties?.split(',').length,
                itemBuilder: (context, index) {
                  String title = tutor.specialties!.split(',')[index];
                  String specialty = listLearningTopics[title] ?? title;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // change blue color
                        logger.i('You just selected $title');
                      },
                      // border for button
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 221, 234, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(specialty,
                          style: kSearchTextStyle.copyWith(
                              color: const Color.fromARGB(255, 0, 113, 240))),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Text(tutor.bio ?? "", style: kSearchPlaceholderStyle),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      // foreroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        // border
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                      size: 15,
                    ),
                    label: Text('Book',
                        style: kCalloutLabelStyle.copyWith(
                            color: Colors.blue, fontSize: 13)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
