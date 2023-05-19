import 'package:beatiful_ui/src/features/tutor/presentation/widget/bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants.dart';
import '../../../../route/app_route.dart';
import '../../../../utils/learning_topics.dart';
import '../../model/tutor_search.dart';
import '../controller/tutor_detail_controller.dart';
import '../tutor_home_page.dart';
import 'detail_review_card.dart';

class MyTutorCardReview extends StatelessWidget {
  const MyTutorCardReview({
    Key? key,
    required this.tutor,
  }) : super(key: key);
  final TutorInfoSearch tutor;

  @override
  Widget build(BuildContext context) {
    final String avatarUrl = getAvatar(tutor.avatar);

    return GestureDetector(
      onTap: () {
        // Get.put(tutor.feedbacks, tag: tutor.userId);
        context.pushNamed(
          AppRoute.tutorDetail.name,
          params: {
            'id': tutor.userId!,
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
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  const SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tutor.name != null) ...{
                        Text(
                          tutor.name!.length > 10
                              ? '${tutor.name!.substring(0, 10)}...'
                              : tutor.name!,
                          style: kHeadlineLabelStyle,
                        ),
                      },
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          SvgPicture.network(
                            'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${"vn"}.svg',
                            width: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text(getCountry(tutor.country),
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
                      padding:
                          const EdgeInsets.only(right: 10.0, left: 10, top: 15),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: tutor.isfavoritetutor != null &&
                                tutor.isfavoritetutor! == "1"
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
            Text(
              tutor.bio ?? "",
              style: kSearchPlaceholderStyle,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
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
                    onPressed: () async {
                      DetailTutorController c = Get.find();
                      c.schedules.value = null;
                      c.getSchedules(tutor.userId!);
                      showTutorDatePicker(context, c);
                    },
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