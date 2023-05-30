import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../model/schedule.dart';
import '../../model/tutor.dart';

import '../../model/tutor_review.dart';
import '../../service/schedule_functions.dart';
import '../../service/tutor_functions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailTutorController extends GetxController {
  Rx<Tutor?> tutor = Rx<Tutor?>(null);

  Tutor? get tutorValue => tutor.value;

  Rx<List<Schedule>?> schedules = Rx<List<Schedule>?>(null);
  List<Schedule>? get schedulesValue => schedules.value;

  Rx<VideoPlayerController?> controller = Rx<VideoPlayerController?>(null);
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);

  var isFavorite = false.obs;

  var isLoading = true.obs;
  late Rx<MyPage> page;
  var totalPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    page = MyPage().obs;
  }

  RxList<TutorReview> reviews = RxList<TutorReview>([]);
  List<TutorReview> get reviewsValue => reviews;

  Future<void> reportTutor(String id, String content, context) async {
    try {
      var ok = await TutorFunctions.reportTutor(id, content);
      if (ok) {
        Get.snackbar(
          AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.reportSuccess,
          // green color
          backgroundColor: Colors.blue[100],
        );
      } else {
        Get.snackbar(
          AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.reportFail,
          backgroundColor: Colors.red[100],
        );
      }
    } on Error catch (_) {
      // Get.snackbar('Error', _.toString());
    }
  }

  Future<void> getReviews(String id) async {
    try {
      var reviewsResponse = await TutorFunctions.getTutorReview(id, page.value);
      if (reviewsResponse != null) {
        reviews.value = reviewsResponse;
        totalPage.value =
            (TutorFunctions.reviewCount / page.value.perPage).ceil();
      } else {}
    } on Error catch (_) {
      // Get.snackbar('Error', _.toString());
    }
  }

  void getReviewAtPage(String id, int index) {
    page.value.page = index;
    getReviews(id);
  }

  Future<void> getTutor(String id) async {
    try {
      isLoading.value = true;
      var tutorResponse = await TutorFunctions.getTutorInfomation(id);
      if (tutorResponse != null) {
        tutor.value = tutorResponse;
        isFavorite.value = tutorResponse.isFavorite ?? false;
      }

      controller.value =
          VideoPlayerController.network(tutor.value!.video as String);
      chewieController.value = ChewieController(
          videoPlayerController: controller.value as VideoPlayerController,
          aspectRatio: 3 / 2,
          autoPlay: true,
          looping: false,
          allowFullScreen: false,
          errorBuilder: (context, errorMessage) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Tutor has not uploaded any video yet',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          });
      isLoading.value = false;
    } on Error {}
  }

  @override
  void dispose() {
    controller.value?.dispose();
    chewieController.value?.dispose();
    controller = Rx<VideoPlayerController?>(null);
    chewieController = Rx<ChewieController?>(null);
  }

  Future<void> toggleFavorite(String id) async {
    TutorFunctions.manageFavoriteTutor(id);
    isFavorite.value = !isFavorite.value;

    // clone tutor value
  }

  Future<void> getSchedules(String tutorId) async {
    List<Schedule>? res = await ScheduleFunctions.getScheduleByTutorId(tutorId);

    // Filter the schedule that has passed
    res = res!.where((schedule) {
      final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp);
      return start.isAfter(now) ||
          (start.day == now.day &&
              start.month == now.month &&
              start.year == now.year);
    }).toList();

    // Sort the schedule by startTimestamp
    res.sort((s1, s2) => s1.startTimestamp.compareTo(s2.startTimestamp));

    List<Schedule> tempRes = [];

    for (int index = 0; index < res.length; index++) {
      bool isExist = false;

      //so group the schedule by day
      for (int index_2 = 0; index_2 < tempRes.length; index_2++) {
        final DateTime first =
            DateTime.fromMillisecondsSinceEpoch(res[index].startTimestamp);
        final DateTime second = DateTime.fromMillisecondsSinceEpoch(
            tempRes[index_2].startTimestamp);
        if (first.day == second.day &&
            first.month == second.month &&
            first.year == second.year) {
          // If exist, add the scheduleDetails to the scheduleDetails of the schedule in tempRes
          tempRes[index_2].scheduleDetails.addAll(res[index].scheduleDetails);
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        tempRes.add(res[index]);
      }
    }
    // sort timestamp for each schedule
    for (int index = 0; index < tempRes.length; index++) {
      tempRes[index].scheduleDetails.sort((s1, s2) => DateTime
              .fromMillisecondsSinceEpoch(s1.startPeriodTimestamp)
          .compareTo(
              DateTime.fromMillisecondsSinceEpoch(s2.startPeriodTimestamp)));
    }
    schedules.value = tempRes;
  }
}
