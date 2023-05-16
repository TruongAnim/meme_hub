import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoadingOverlay {
  static void show() {
    BuildContext? context = Get.overlayContext;
    if (context != null) {
      context.loaderOverlay.show();
    }
  }

  static void hide() {
    BuildContext? context = Get.overlayContext;
    if (context != null) {
      context.loaderOverlay.hide();
    }
  }
}
