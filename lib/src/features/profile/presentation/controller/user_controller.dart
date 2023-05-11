import 'dart:io';

import 'package:beatiful_ui/src/utils/learning_topics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/learning_topic.dart';
import '../../model/test_preparation.dart';
import '../../model/user_info.dart';
import '../../service/user_functions.dart';

class UserController extends GetxController {
  // Get the user information
  final Rx<UserInfo?> _user = Rx<UserInfo?>(null);
  UserInfo? get user => _user.value;

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  final schedule = "".obs;

  RxList<LearnTopic> topics = <LearnTopic>[].obs;
  RxList<TestPreparation> preparations = <TestPreparation>[].obs;

  List<String> newTopics = [];
  List<String> newPreparation = [];
  File? avatar;

  @override
  void onReady() {
    getUserInformation();
  }

  @override
  void onClose() {
    nameController.dispose();
    dateController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Get the user information from the API
  Future<void> getUserInformation() async {
    _user.value = await UserFunctions.getUserInformation();
    nameController.text = _user.value?.name ?? "";
    dateController.text = _user.value?.birthday ?? "";
    phoneController.text = _user.value?.phone ?? "";
    schedule.value = _user.value?.studySchedule ?? "";
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
    topics.value = (await UserFunctions.getAllLearningTopic()) ?? [];
    newTopics = topics.value.map((e) => e.name).toList();
    // _user.update((val) {
    //   val?.learnTopics = topics.value;
    // });
  }

  // Get all test preparations
  Future<void> getAllTestPreparation() async {
    preparations.value = (await UserFunctions.getAllTestPreparation()) ?? [];
    newPreparation = preparations.value.map((e) => e.name).toList();
    // _user.update((val) {
    //   val?.testPreparations = preparations.value;
    // });
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
    final res = await UserFunctions.updateUserInformation(
      name,
      country,
      birthday,
      level,
      studySchedule,
      learnTopics,
      testPreparations,
    );
    Get.snackbar("Success", "Update user information successfully");
    return res;
  }

  // Upload avatar
  Future<bool> uploadAvatar(String path) async {
    return await UserFunctions.uploadAvatar(path);
  }

  Future<UserInfo?> updateUserInfo() async {
    String name = nameController.text;
    String birthday = dateController.text;
    String phone = phoneController.text;
    String country = _user.value?.country ?? "";
    String level = _user.value?.level ?? "";
    if (name.isEmpty) {
      Get.snackbar("Error", "Name is empty");
      return null;
    }
    if (birthday.isEmpty) {
      Get.snackbar("Error", "Birthday is empty");
      return null;
    }
    if (phone.isEmpty) {
      Get.snackbar("Error", "Phone is empty");
      return null;
    }

    if (country.isEmpty) {
      Get.snackbar("Error", "Country is empty");
      return null;
    }

    if (level.isEmpty) {
      Get.snackbar("Error", "Level is empty");
      return null;
    }

    List<String>? learnTopics = newTopics.map((e) {
      return topicsList[e].toString();
    }).toList();

    if (learnTopics.isEmpty) {
      Get.snackbar("Error", "Learning topic is empty");
      return null;
    }
    List<String>? testPreparations =
        newPreparation.map((e) => prepareList[e].toString()).toList();
    if (testPreparations.isEmpty) {
      Get.snackbar("Error", "Test preparation is empty");
      return null;
    }
    if (avatar != null) {
      await uploadAvatar(avatar!.path);
    }
    return await updateUserInformation(name, country, birthday, level,
        schedule.value, learnTopics, testPreparations);
  }
}
