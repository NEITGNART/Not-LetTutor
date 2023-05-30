import 'package:beatiful_ui/src/features/tutor/presentation/controller/tutor_detail_controller.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/constants.dart';
import '../../../../route/app_route.dart';
import '../../service/tutor_functions.dart';
import '../tutor_home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Text(
              AppLocalizations.of(context)!.helpUs,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text(AppLocalizations.of(context)!.annoyTitle),
              value: isAnnoying,
              onChanged: (bool? value) {
                setState(() {
                  isAnnoying = value ?? false;
                  if (isAnnoying) {
                    additionalDetailsController.text +=
                        AppLocalizations.of(context)!.annoyContent;
                  } else {
                    additionalDetailsController.text =
                        additionalDetailsController.text.replaceAll(
                            AppLocalizations.of(context)!.annoyContent, '');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text(AppLocalizations.of(context)!.fakeTitle),
              value: isFakeProfile,
              onChanged: (bool? value) {
                setState(() {
                  isFakeProfile = value ?? false;
                  if (isFakeProfile) {
                    additionalDetailsController.text +=
                        AppLocalizations.of(context)!.fakeContent;
                  } else {
                    additionalDetailsController.text =
                        additionalDetailsController.text.replaceAll(
                            AppLocalizations.of(context)!.fakeContent, '');
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
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.problems,
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
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    DetailTutorController c = Get.find();
                    if (c.tutorValue == null) {
                      return;
                    }
                    if (additionalDetailsController.text.isEmpty) {
                      Get.snackbar(
                        AppLocalizations.of(context)!.error,
                        AppLocalizations.of(context)!.problems,
                        backgroundColor: Colors.red[100],
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    c.reportTutor(c.tutorValue!.userId,
                        additionalDetailsController.text, context);
                    // );
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.submit),
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
                SizedBox(
                    height: 200, child: Image.asset('asset/images/empty.png')),
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
                            Text(AppLocalizations.of(context)!.noRating,
                                style: kSearchPlaceholderStyle),
                          }
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Flag.fromString(
                            tutor.country ?? 'VN',
                            height: 20,
                            width: 20,
                            replacement: const SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.flag,
                                  color: Colors.blue,
                                )),
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
                              AppLocalizations.of(context)!.favorite,
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
                    child: Column(
                      children: [
                        const Icon(Icons.report_outlined),
                        Text(AppLocalizations.of(context)!.report),
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
                    child: Column(
                      children: [
                        const Icon(Icons.star_border_sharp),
                        Text(AppLocalizations.of(context)!.review),
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
