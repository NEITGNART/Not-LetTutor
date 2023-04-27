import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_info.dart';
import '../../service/user_functions.dart';

class UserController extends GetxController {
  // Get the user information
  final Rx<UserInfo?> _user = Rx<UserInfo?>(null);
  UserInfo? get user => _user.value;

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _getUserInformation();
  }

  // Get the user information from the API
  Future<void> _getUserInformation() async {
    _user.value = await UserFunctions.getUserInformation();
    nameController.text = _user.value?.name ?? "";
    dateController.text = _user.value?.birthday ?? "";
    phoneController.text = _user.value?.phone ?? "";
    await getAllLearningTopic();
    await getAllTestPreparation();
  }

  // Update country
  void updateCountry(String country) {
    _user.update((val) {
      val?.country = country;
    });
  }

  void updateLevel(String level) {
    _user.update((val) {
      val?.level = level;
    });
  }

  // Forgot password
  Future<void> forgotPassword(String email) async {
    var result = await UserFunctions.forgotPassword(email);
    // if (result['isSuccess']) {
    //   // Show success message
    // } else {
    //   // Show error message
    // }
  }

  // Get all learning topics
  Future<void> getAllLearningTopic() async {
    final learnTopics = await UserFunctions.getAllLearningTopic();
    _user.update((val) {
      val?.learnTopics = learnTopics;
    });
  }

  // Get all test preparations
  Future<void> getAllTestPreparation() async {
    final tests = await UserFunctions.getAllTestPreparation();
    _user.update((val) {
      val?.testPreparations = tests;
    });
  }

  // Update user information
  Future<UserInfo?> updateUserInformation(
      String name,
      String country,
      String birthday,
      String level,
      String studySchedule,
      List<String>? learnTopics,
      List<String>? testPreparations) async {
    return await UserFunctions.updateUserInformation(
      name,
      country,
      birthday,
      level,
      studySchedule,
      learnTopics,
      testPreparations,
    );
  }

  // Upload avatar
  Future<bool> uploadAvatar(String path) async {
    return await UserFunctions.uploadAvatar(path);
  }
}
