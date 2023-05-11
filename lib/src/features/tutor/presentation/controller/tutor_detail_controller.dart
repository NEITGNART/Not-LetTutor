import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../model/schedule.dart';
import '../../model/tutor.dart';

import '../../service/schedule_functions.dart';
import '../../service/tutor_functions.dart';

class DetailTutorController extends GetxController {
  Rx<Tutor?> tutor = Rx<Tutor?>(null);

  Tutor? get tutorValue => tutor.value;

  Rx<List<Schedule>?> schedules = Rx<List<Schedule>?>(null);
  List<Schedule>? get schedulesValue => schedules.value;

  Rx<VideoPlayerController?> controller = Rx<VideoPlayerController?>(null);
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);

  var isFavorite = false.obs;

  var isLoading = true.obs;
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
          autoPlay: true,
          looping: true,
          allowFullScreen: true);

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
    res = res!.where((schedule) {
      final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp);
      return start.isAfter(now) ||
          (start.day == now.day &&
              start.month == now.month &&
              start.year == now.year);
    }).toList();
    res.sort((s1, s2) => s1.startTimestamp.compareTo(s2.startTimestamp));

    List<Schedule> tempRes = [];

    for (int index = 0; index < res.length; index++) {
      bool isExist = false;
      for (int index_2 = 0; index_2 < tempRes.length; index_2++) {
        final DateTime first =
            DateTime.fromMillisecondsSinceEpoch(res[index].startTimestamp);
        final DateTime second = DateTime.fromMillisecondsSinceEpoch(
            tempRes[index_2].startTimestamp);
        if (first.day == second.day &&
            first.month == second.month &&
            first.year == second.year) {
          tempRes[index_2].scheduleDetails.addAll(res[index].scheduleDetails);
          isExist = true;
          break;
        }
      }

      if (!isExist) {
        tempRes.add(res[index]);
      }
    }

    for (int index = 0; index < tempRes.length; index++) {
      tempRes[index].scheduleDetails.sort((s1, s2) => DateTime
              .fromMillisecondsSinceEpoch(s1.startPeriodTimestamp)
          .compareTo(
              DateTime.fromMillisecondsSinceEpoch(s2.startPeriodTimestamp)));
    }
    schedules.value = tempRes;
  }
}
