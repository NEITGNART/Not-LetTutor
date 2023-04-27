import 'package:beatiful_ui/src/features/tutor/service/schedule_functions.dart';
import 'package:get/get.dart';

import '../../../tutor/model/booking_info.dart';

class ScheduleController extends GetxController {
  var isLoading = true.obs;
  var currentPage = 1.obs; // get
  var perPage = 10.obs;

  RxList<BookingInfo> upcomingClasses = <BookingInfo>[].obs;
  RxList<BookingInfo> bookedClasses = <BookingInfo>[].obs;

  Future<bool> cancelClass(String scheduleDetailIds) async {
    return await ScheduleFunctions.cancelClass(scheduleDetailIds);
  }

  // onload
  @override
  void onInit() {
    super.onInit();
    getUpcomingClass();
    getBookedClass();

    currentPage.listen((p0) {
      getUpcomingClass();
      getBookedClass();
    });
  }

  void getUpcomingClass() async {
    try {
      isLoading.value = true;
      upcomingClasses.value = (await ScheduleFunctions.getUpcomingClass(
          currentPage.value, perPage.value))!;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        // bottom
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void getBookedClass() async {
    try {
      isLoading.value = true;
      bookedClasses.value = (await ScheduleFunctions.getBookedClass(
          currentPage.value, perPage.value))!;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        // bottom
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void nextPage() {
    currentPage.value++;
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  void goToPage(int page) {
    currentPage.value = page;
  }
}
