import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants.dart';
import '../../../../route/app_route.dart';
import '../../service/tutor_functions.dart';
import '../tutor_home_page.dart';

class ReportTeacherDialog extends StatefulWidget {
  const ReportTeacherDialog({super.key});

  @override
  _ReportTeacherDialogState createState() => _ReportTeacherDialogState();
}

class _ReportTeacherDialogState extends State<ReportTeacherDialog> {
  bool isAnnoying = false;
  bool isFakeProfile = false;
  bool hasInappropriatePhoto = false;
  TextEditingController additionalDetailsController = TextEditingController();

  @override
  void dispose() {
    additionalDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help us understand what\'s happening',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: const Text('This tutor is annoying me'),
              value: isAnnoying,
              onChanged: (bool? value) {
                setState(() {
                  isAnnoying = value ?? false;
                  if (isAnnoying) {
                    additionalDetailsController.text +=
                        'This tutor is annoying me. ';
                  } else {
                    additionalDetailsController.text =
                        additionalDetailsController.text
                            .replaceAll('This tutor is annoying me. ', '');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text(
                  'This profile is pretending to be someone or is fake'),
              value: isFakeProfile,
              onChanged: (bool? value) {
                setState(() {
                  isFakeProfile = value ?? false;
                  if (isFakeProfile) {
                    additionalDetailsController.text +=
                        'This profile is pretending to be someone or is fake. ';
                  } else {
                    additionalDetailsController.text =
                        additionalDetailsController.text.replaceAll(
                            'This profile is pretending to be someone or is fake. ',
                            '');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Inappropriate profile photo'),
              value: hasInappropriatePhoto,
              onChanged: (bool? value) {
                setState(() {
                  hasInappropriatePhoto = value ?? false;
                  if (hasInappropriatePhoto) {
                    additionalDetailsController.text +=
                        'Inappropriate profile photo. ';
                  } else {
                    additionalDetailsController.text =
                        additionalDetailsController.text
                            .replaceAll('Inappropriate profile photo. ', '');
                  }
                });
              },
            ),
            TextField(
              controller: additionalDetailsController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Please let us know details about your problem',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    DetailTutorController c = Get.find();
                    if (c.tutorValue == null) {
                      return;
                    }
                    if (additionalDetailsController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please let us know details about your problem',
                        backgroundColor: Colors.red[100],
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    c.reportTutor(
                        c.tutorValue!.userId, additionalDetailsController.text);
                    // );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
      child: Obx(
        () {
          if (c.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (c.tutorValue == null) {
            return Column(
              children: [
                SvgPicture.asset(
                  "asset/svg/ic_notfound.svg",
                  width: 200,
                ),
                const Center(child: Text('No data')),
              ],
            );
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
                      SizedBox(
                        width: 200,
                        child: Text(
                          tutor.name ?? "",
                          style: kHeadlineLabelStyle,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          if (c.tutorValue?.rating != null) ...{
                            getStarsWidget(5, c.tutorValue!.rating!.floor()),
                            Text(
                              '${TutorFunctions.reviewCount}',
                              style: kSearchPlaceholderStyle,
                            ),
                          } else ...{
                            Text('No rating', style: kSearchPlaceholderStyle),
                          }
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          DetailTutorController c = Get.find();
                          return const ReportTeacherDialog();
                        },
                      );
                    },
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
