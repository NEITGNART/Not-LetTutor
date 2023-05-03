import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/date_format.dart';
import '../../../tutor/model/booking_info.dart';
import '../../../tutor/model/tutor.dart';

class MeetingController extends GetxController {
  var formatDate = ''.obs;
  var countDown = ''.obs;
  var starTime = 0;
  Rx<Tutor?> tutor = Rx<Tutor?>(null);
  Timer? timmer;

  @override
  void onClose() {
    timmer?.cancel();
  }

  void init(BookingInfo bookingInfo) {
    timmer?.cancel();
    getTimeLeft(bookingInfo.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
    tutor.value = bookingInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo;

    final startTime = bookingInfo.scheduleDetailInfo?.startPeriodTimestamp ?? 0;
    final s = DateFormat('EEE, d MMM yyyy HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(startTime));
    var rest = s;
    formatDate.value = rest;
  }

  void getTimeLeft(int t) {
    final startTime = DateTime.fromMillisecondsSinceEpoch(t);
    timmer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        final difference = startTime.difference(DateTime.now());
        countDown.value = printDuration(difference);
        if (difference <= const Duration(seconds: 0)) {
          countDown.value = "00:00:00";
          t.cancel();
        }
      },
    );
  }
}
