import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message, {onclick}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    duration: const Duration(seconds: 10),
    onTap: (snack) {
      onclick();
    },
  );
}
