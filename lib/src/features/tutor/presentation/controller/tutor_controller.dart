import 'package:get/get.dart';

import '../../model/tutor.dart';
import '../../service/tutor_functions.dart';

class TutorController extends GetxController {
  var tutorList = <Tutor>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  final int perPage = 10;

  @override
  void onInit() {
    super.onInit();
    fetchTutorList();
  }

  Future<void> fetchTutorList() async {
    try {
      isLoading(true);
      var tutors =
          await TutorFunctions.getTutorList(currentPage.value, perPage);
      if (tutors != null) {
        tutorList.assignAll(tutors);
      }
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
      var tutors = await TutorFunctions.searchTutor(currentPage.value, perPage,
          search: query);
      if (tutors != null) {
        tutorList.assignAll(tutors);
      }
    } finally {
      isLoading(false);
    }
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
}
