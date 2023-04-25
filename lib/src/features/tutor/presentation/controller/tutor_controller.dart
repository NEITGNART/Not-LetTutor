import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../utils/countries_list.dart';
import '../../model/tutor.dart';
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

  @override
  void onInit() {
    super.onInit();
    fetchTutorList();
    search.addListener(() {
      Logger().d(search.text);
      searchText.value = search.text;
    });
    debounce(searchText, (_) {
      searchTutors(searchText.value);
    }, time: const Duration(milliseconds: 300));
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
}
