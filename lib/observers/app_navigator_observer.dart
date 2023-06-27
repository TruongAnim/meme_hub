import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
import 'package:meme_hub/routes/app_routes.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == AppRoutes.user) {
      Get.find<UserController>().removeUserId();
    }
  }
}
