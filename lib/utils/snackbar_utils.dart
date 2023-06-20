import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  static void showError(String title, String content) {
    Get.snackbar(title, content, colorText: Colors.red);
  }

  static void showInfo(String title, String content) {
    Get.snackbar(title, content, colorText: Colors.lightBlue);
  }
}
