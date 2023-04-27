import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants.dart';
import '../../../../route/app_route.dart';
import '../tutor_home_page.dart';

Widget getStarsWidget(int totalStart, int goldenStars) {
  assert(totalStart >= goldenStars);
  return Row(
    children: [
      ...List.generate(
          goldenStars,
          (i) => const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 15,
              )),
      ...List.generate(
          totalStart - goldenStars,
          (i) => const Icon(
                Icons.star,
                color: Colors.grey,
                size: 15,
              )),
      const SizedBox(width: 5.0),
    ],
  );
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});
  @override
  Widget build(BuildContext context) {
    DetailTutorController c = Get.find();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // color: const Color(0xFF00AEFF).withOpacity(0.5),
            // purple
            color: const Color(0xFF6F35A5).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(right: 10.0),
      child: Obx(
        () {
          if (c.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (c.tutorValue == null) {
            return const Center(child: Text('No data'));
          }
          final tutor = c.tutorValue!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    // width: 100,
                    // height: 100,
                    backgroundImage: NetworkImage(getAvatar(tutor.avatar)),
                  ),
                  const SizedBox(width: 15.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
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
                          getStarsWidget(5, 5),
                          Text('(88)', style: kSearchPlaceholderStyle),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          SvgPicture.network(
                            'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
                            width: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text(getCountry(tutor.country),
                              style: kSearchPlaceholderStyle),
                          const SizedBox(width: 5.0),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ],
              ),
              gapH12,
              Text(tutor.bio ?? "", style: kSearchPlaceholderStyle),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        c.toggleFavorite(tutor.userId);
                      },
                      style: ButtonStyle(
                        // set padding = 0
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                        // not display shadow and border
                        elevation: MaterialStateProperty.all(0.0),
                      ),
                      child: Obx(
                        () => Column(
                          children: [
                            c.isFavorite.value
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red.shade400,
                                  )
                                : const Icon(Icons.favorite_outline),
                            Text(
                              'Favorite',
                              style: TextStyle(
                                  color: c.isFavorite.value
                                      ? Colors.red.shade400
                                      : Colors.blue),
                            ),
                          ],
                        ),
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                      // not display shadow and border
                      elevation: MaterialStateProperty.all(0.0),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.report_outlined),
                        Text('Report'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.review.name, params: {
                        'tutorId': tutor.userId,
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                      // not display shadow and border
                      elevation: MaterialStateProperty.all(0.0),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.star_border_sharp),
                        Text('Review'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
