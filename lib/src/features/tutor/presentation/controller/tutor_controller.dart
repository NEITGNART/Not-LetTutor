import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../../utils/countries_list.dart';
import '../../../../utils/date_format.dart';
import '../../model/booking_info.dart';
import '../../model/tutor.dart';
import '../../service/schedule_functions.dart';
import '../../service/tutor_functions.dart';

const all = 'All';

class TutorController extends GetxController {
  var tutorList = <Tutor>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  final int perPage = 10;
  var search = TextEditingController(text: '');
  RxString searchText = ''.obs;
  var specialty = all;
  var hoursTotal = const Duration().obs;
  Rx<BookingInfo?> nextClass = Rx<BookingInfo?>(null);
  var formatDate = ''.obs;
  var countDown = ''.obs;
  late final Worker worker;

  @override
  void onReady() {
    search.addListener(() {
      searchText.value = search.text;
    });
    worker = debounce(searchText, (_) {
      searchTutors(searchText.value);
    }, time: const Duration(milliseconds: 500));
  }

  void init() {
    fetchTutorList();
    getTotalAndNextLesson();
  }

  @override
  void onClose() {
    search.dispose();
    worker.dispose();
  }

  Future<void> fetchTutorList() async {
    try {
      isLoading(true);
      // var tutors = await TutorFunctions.searchTutor(currentPage.value, perPage,
      //     search: '');

      //   var tutors =
      var tutors =
          await TutorFunctions.getTutorList(currentPage.value, perPage);
      tutorList.assignAll(tutors!);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchMoreTutors() async {
    try {
      isLoading(true);
      currentPage++;
      var tutors =
          await TutorFunctions.getTutorList(currentPage.value, perPage);
      if (tutors != null) {
        tutorList.addAll(tutors);
      } else {
        currentPage--;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchTutors(String query) async {
    try {
      isLoading(true);
      List<Tutor> tutors = [];
      if (query.isEmpty) {
        tutors = await TutorFunctions.searchTutor(currentPage.value, perPage,
            search: query);
      } else {
        for (var tutor in tutorList) {
          final country = countryList[tutor.country] ?? tutor.country!;
          if (country.toLowerCase().contains(query.toLowerCase()) ||
              tutor.name!.toLowerCase().contains(query.toLowerCase())) {
            tutors.add(tutor);
          }
        }
      }

      if (specialty == all) {
        tutorList.assignAll(tutors);
      } else {
        final res = tutors.where((e) {
          return e.specialties!.contains(specialty);
        });
        tutorList.assignAll(res);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> filterBySpecialty(String spec) async {
    specialty = spec;

    if (spec == all) {
      searchTutors(search.text);
      return;
    }

    final res = tutorList.toList().where((e) {
      return e.specialties!.contains(specialty);
    });
    tutorList.assignAll(res);
  }

  Future<void> toggleFavoriteTutor(String tutorId) async {
    try {
      isLoading(true);
      var isSuccess = await TutorFunctions.manageFavoriteTutor(tutorId);
      if (isSuccess) {
        var tutorIndex =
            tutorList.indexWhere((tutor) => tutor.userId == tutorId);
        if (tutorIndex != -1) {
          final isFavorite = tutorList[tutorIndex].isFavorite;
          tutorList[tutorIndex].isFavorite = !isFavorite!;
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void resetFilter() {
    search.clear();
    specialty = all;
    filterBySpecialty(all);
  }

  void getTimeLeft(int t) {
    final startTime = DateTime.fromMillisecondsSinceEpoch(t);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final difference = startTime.difference(DateTime.now());
      countDown.value = printDuration(difference);
      if (difference <= const Duration(seconds: 0)) {
        timer.cancel();
      }
    });
  }

  void getTotalAndNextLesson() async {
    final total = await ScheduleFunctions.getTotalHourLesson();
    final next = await ScheduleFunctions.getNextClass();
    Logger().e(next);
    hoursTotal.value = Duration(minutes: total);
    nextClass.value = next;

    if (next == null) return;
    final tmp = nextClass.value!;
    final startTime = tmp.scheduleDetailInfo?.startPeriodTimestamp ?? 0;
    final endTime = tmp.scheduleDetailInfo?.endPeriodTimestamp ?? 0;
    final s = DateFormat('EEE, d MMM yyyy HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(startTime));
    final se = DateFormat('HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(endTime));
    var rest = '$s - $se';
    formatDate.value = rest;
    getTimeLeft(startTime);

    // if (mounted) {
    //   setState(() {
    //     totalHourLesson = Duration(minutes: total);
    //     nextClass = next;
    //     isLoading = false;
    //   });
    // }
  }
}
