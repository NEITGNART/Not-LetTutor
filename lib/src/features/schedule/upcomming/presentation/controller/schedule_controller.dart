import 'dart:async';

import 'package:beatiful_ui/src/features/tutor/service/schedule_functions.dart';
import 'package:get/get.dart';

import '../../../../../utils/date_format.dart';
import '../../../../tutor/model/booking_info.dart';

class ScheduleController extends GetxController {
  var isLoading = true.obs;
  var currentPage = 1.obs; // get
  var perPage = 2.obs;
  var formatDate = ''.obs;
  var countDown = ''.obs;
  var starTime = 0;
  var totalPage = 0.obs;

  late Timer timer;

  RxList<BookingInfo> upcomingClasses = <BookingInfo>[].obs;

  Future<bool> cancelClass(String scheduleDetailIds) async {
    return await ScheduleFunctions.cancelClass(scheduleDetailIds);
  }

  @override
  void onReady() {
    currentPage.listen(
      (p0) {
        getUpcomingClass();
      },
    );
  }

  void init() {
    getUpcomingClass();
    // getBookedClass();
  }

  @override
  void onClose() {
    timer.cancel();
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

  void getUpcomingClass() async {
    try {
      isLoading.value = true;
      upcomingClasses.value = (await ScheduleFunctions.getUpcomingClass(
          currentPage.value, perPage.value))!;
      totalPage.value = (ScheduleFunctions.count / perPage.value).ceil();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar(
      //   'Error',
      //   e.toString(),
      //   // bottom
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    }
  }

  void goToPage(int page) {
    currentPage.value = page;
  }
}
