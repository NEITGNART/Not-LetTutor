import 'package:beatiful_ui/src/features/tutor/service/schedule_functions.dart';
import 'package:get/get.dart';

import '../../../../tutor/model/booking_info.dart';

class HistoryController extends GetxController {
  var isLoading = true.obs;
  var currentPage = 1.obs; // get
  var perPage = 12.obs;
  var totalPage = 0.obs;

  RxList<BookingInfo> bookedClasses = <BookingInfo>[].obs;

  @override
  void onReady() {
    currentPage.listen(
      (p0) {
        getBookedClass();
      },
    );
  }

  void init() {
    getBookedClass();
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
        'Error'.tr,
        e.toString(),
        // bottom
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void goToPage(int page) {
    currentPage.value = page;
  }
}
