


// class ScheduleController extends GetxController {
//   Rx<List<Schedule>> schedules = Rx<List<Schedule>>([]);
//   Rx<List<BookingInfo>> upcomingClasses = Rx<List<BookingInfo>>([]);
//   Rx<List<BookingInfo>> bookedClasses = Rx<List<BookingInfo>>([]);
//   Rx<int> totalHourLesson = Rx<int>(0);
//   Rx<BookingInfo?> nextClass = Rx<BookingInfo?>(null);

//   @override
//   void onInit() {
//     super.onInit();
//     getSchedules();
//     getUpcomingClasses();
//     getBookedClasses();
//     getTotalHourLesson();
//     getNextClass();
//   }

//   Future<void> getSchedules() async {
//     try {
//       var schedules = await _scheduleFunctions.getSchedules();
//       this.schedules.value = schedules;
//     } on Error catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }

//   Future<void> getUpcomingClasses() async {
//     try {
//       var upcomingClasses = await _scheduleFunctions.getUpcomingClasses(1, 10);
//       this.upcomingClasses.value = upcomingClasses;
//     } on Error catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }

//   Future<void> getBookedClasses() async {
//     try {
//       var bookedClasses = await _scheduleFunctions.getBookedClasses(1, 10);
//       this.bookedClasses.value = bookedClasses;
//     } on Error catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }

//   Future<void> getTotalHourLesson() async {
//     try {
//       var totalHourLesson = await _scheduleFunctions.getTotalHourLesson();
//       this.totalHourLesson.value = totalHourLesson;
//     } on Error catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }

//   Future<void> getNextClass() async {
//     try {
//       var nextClass = await _scheduleFunctions.getNextClass();
//       this.nextClass.value = nextClass;
//     } on Error catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }
// }