import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  static void showError(String? title, String? message) {
    Get.snackbar(title ?? 'Error!', message ?? '', colorText: Colors.red);
  }

  static void showInfo(String? title, String? message) {
    Get.snackbar(title ?? 'Error!', message ?? '', colorText: Colors.lightBlue);
  }
}
