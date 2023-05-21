import 'dart:io';

import 'package:beatiful_ui/src/utils/learning_topics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_info.dart';
import '../../service/user_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserController extends GetxController {
  // Get the user information
  final Rx<UserInfo?> _user = Rx<UserInfo?>(null);
  UserInfo? get user => _user.value;

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  final schedule = "".obs;

  Rx<List<String>> newTopics = Rx<List<String>>([]);
  Rx<List<String>> newPreparation = Rx<List<String>>([]);
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
    newPreparation.value =
        _user.value?.testPreparations?.map((e) => e.name).toList() ?? [];
    newTopics.value =
        _user.value?.learnTopics?.map((e) => e.name).toList() ?? [];
    // await getAllLearningTopic();
    // await getAllTestPreparation();
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

  // // Get all learning topics
  // Future<void> getAllLearningTopic() async {
  //   topics.value = (await UserFunctions.getAllLearningTopic()) ?? [];
  //   newTopics = topics.value.map((e) => e.name).toList();
  //   // _user.update((val) {
  //   //   val?.learnTopics = topics.value;
  //   // });
  // }

  // // Get all test preparations
  // Future<void> getAllTestPreparation() async {
  //   preparations.value = (await UserFunctions.getAllTestPreparation()) ?? [];
  //   newPreparation.value = preparations.value.map((e) => e.name).toList();
  //   Logger().i(newPreparation.value);
  //   // _user.update((val) {
  //   //   val?.testPreparations = preparations.value;
  //   // });
  // }

  // Update user information
  Future<UserInfo?> updateUserInformation(
      String name,
      String country,
      String birthday,
      String level,
      String studySchedule,
      List<String>? learnTopics,
      List<String>? testPreparations,
      context) async {
    final res = await UserFunctions.updateUserInformation(
      name,
      country,
      birthday,
      level,
      studySchedule,
      learnTopics,
      testPreparations,
    );
    Get.snackbar(AppLocalizations.of(context)!.success,
        AppLocalizations.of(context)!.updateSuccess);
    return res;
  }

  // Upload avatar
  Future<bool> uploadAvatar(String path) async {
    return await UserFunctions.uploadAvatar(path);
  }

  Future<UserInfo?> updateUserInfo(BuildContext context) async {
    String name = nameController.text;
    String birthday = dateController.text;
    String phone = phoneController.text;
    String country = _user.value?.country ?? "";
    String level = _user.value?.level ?? "";
    if (name.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.emptyName);
      return null;
    }
    if (birthday.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.emptyBirthday);
      return null;
    }
    if (phone.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.emptyPhone);
      return null;
    }

    if (country.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.emptyCountry);
      return null;
    }

    if (level.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.emptyLevel);
      return null;
    }

    List<String>? learnTopics = newTopics.value.map((e) {
      return topicsList[e].toString();
    }).toList();

    if (learnTopics.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.emptyTopic);
      return null;
    }
    List<String>? testPreparations =
        newPreparation.value.map((e) => prepareList[e].toString()).toList();
    if (testPreparations.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.testEmpty);
      return null;
    }
    if (avatar != null) {
      await uploadAvatar(avatar!.path);
    }
    return await updateUserInformation(name, country, birthday, level,
        schedule.value, learnTopics, testPreparations, context);
  }
}
