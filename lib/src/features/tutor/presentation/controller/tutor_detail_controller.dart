import 'package:get/get.dart';

import '../../model/tutor.dart';

import '../../service/tutor_functions.dart';

class TutorDetailController extends GetxController {
  Rx<Tutor?> tutor = Rx<Tutor?>(null);

  Future<void> getTutor(String id) async {
    try {
      var tutorResponse = await TutorFunctions.getTutorInfomation(id);
      if (tutorResponse != null) {
        tutor.value = tutorResponse;
      }
    } on Error catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
