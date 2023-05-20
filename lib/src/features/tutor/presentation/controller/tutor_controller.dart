import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/date_format.dart';
import '../../model/booking_info.dart';
import '../../model/filter_tutor.dart';
import '../../model/tutor_search.dart';
import '../../service/schedule_functions.dart';
import '../../service/tutor_functions.dart';

const all = 'All';

class TutorController extends GetxController {
  // var tutorList = <Tutor>[].obs;
  var tutorList = <TutorInfoSearch>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController(text: '');
  RxString searchText = ''.obs;
  var specialty = all;
  var hoursTotal = const Duration().obs;
  Rx<BookingInfo?> nextClass = Rx<BookingInfo?>(null);
  var formatDate = ''.obs;
  var countDown = ''.obs;
  late final Worker worker;
  late ScrollController scrollController;
  late SearchFilter filters;

  var isLoadMore = false.obs;
  Timer? timer;

  @override
  void onInit() {
    filters = SearchFilter(
      filters: Filters(
        nationality: {},
      ),
      page: 1,
      perPage: 12,
    );
    scrollController = ScrollController()..addListener(loadMore);
    super.onInit();
  }

  @override
  void onReady() {
    search.addListener(() {
      searchText.value = search.text;
    });
    worker = debounce(searchText, (_) {
      if (searchText.value.isEmpty) {
        return;
      }
      searchTutors(searchText.value);
    }, time: const Duration(milliseconds: 1000));
  }

  void init() {
    resetState();
    getTotalAndNextLesson();
    fetchSearchList();
  }

  @override
  void onClose() {
    scrollController.removeListener(loadMore);
    scrollController.dispose();
    search.dispose();
    worker.dispose();
  }

  Future<void> fetchSearchList() async {
    try {
      var tutors = await TutorFunctions.getTutorList(filters);
      tutorList.assignAll(tutors ?? []);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMoreTutors() async {
    try {
      isLoadMore.value = true;
      var tutors = await TutorFunctions.getTutorList(filters);
      if (tutors != null) {
        tutorList.addAll(tutors);
      }
    } finally {
      isLoadMore.value = false;
    }
  }

  void loadMore() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      filters.page = filters.page! + 1;
      await fetchMoreTutors();
    } else {}
    //   setState(() {
    //     // isLoadMore = true;
    //     page++;
    //   });
    //   try {
    //     List<Ebook>? response = await EbookFunctions.getListEbookWithPagination(
    //         page, perPage,
    //         categoryId: category, q: search);
    //     if (mounted) {
    //       setState(() {
    //         _results.addAll(response!);
    //         isLoadMore = false;
    //       });
    //     }
    //   } catch (e) {
    //     const snackBar = SnackBar(
    //       content: Text('Không thể tải thêm nữa'),
    //     );
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   }
    // }
  }

  Future<void> searchTutors(String search) async {
    try {
      isLoading(true);
      filters.search = search;
      filters.page = 1;
      var tutors = await TutorFunctions.getTutorList(filters);
      tutorList.assignAll(tutors ?? []);
    } finally {
      isLoading(false);
    }
  }

  Future<void> filterBySpecialty(String spec) async {
    specialty = spec;
    if (spec == all) {
      filters.filters?.specialties = [];
    } else {
      filters.filters?.specialties = [spec];
    }
    var tutors = await TutorFunctions.getTutorList(filters);
    tutorList.assignAll(tutors ?? []);
  }

  Future<void> filterByNationality(List<String> national) async {
    getNationalityFilter(national);
    var tutors = await TutorFunctions.getTutorList(filters);
    tutorList.assignAll(tutors!);
  }

  void getNationalityFilter(List<String> national) {
    List<String> options = [
      'Forein Tutor',
      'Vietnamese Tutor',
      'Native English Tutor',
    ];
    if (national.isEmpty || national.length == 3) {
      filters.filters?.nationality = {};
    } else if (national.length == 1) {
      if (national.contains(options[0])) {
        filters.filters?.nationality = {
          'isNative': false,
          'isVietNamese': false
        };
      } else if (national.contains(options[1])) {
        filters.filters?.nationality = {'isVietNamese': true};
      } else {
        filters.filters?.nationality = {'isNative': true};
      }
    } else {
      if (national.contains(options[0]) && national.contains(options[1])) {
        filters.filters?.nationality = {'isNative': false};
      }
      if (national.contains(options[1]) && national.contains(options[2])) {
        filters.filters?.nationality = {'isNative': true, 'isVietNamese': true};
      } else {
        filters.filters?.nationality = {'isVietNamese': false};
      }
    }
  }

  Future<void> toggleFavoriteTutor(String tutorId) async {
    try {
      isLoading(true);
      var isSuccess = await TutorFunctions.manageFavoriteTutor(tutorId);
      if (isSuccess) {}
    } finally {
      isLoading(false);
    }
  }

  void resetState() {
    search.clear();
    filters.page = 1;
    filters.search = '';
    filters.filters?.nationality = {};
    specialty = all;
  }

  void resetFilter() {
    resetState();
    filterBySpecialty(all);
  }

  void getTimeLeft(int t) {
    timer?.cancel();
    final startTime = DateTime.fromMillisecondsSinceEpoch(t);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    hoursTotal.value = Duration(minutes: total ?? 0);
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
