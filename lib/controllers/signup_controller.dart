import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/signup_service.dart';
import 'package:meme_hub/utils/loading_overlay.dart';

class SignupController extends GetxController {
  void toLoginScreen() {
    Get.offNamed(AppRoutes.login);
  }

  void signup(String username, String email, String password) async {
    LoadingOverlay.show();
    await Future.delayed(Duration(seconds: 3));
    LoadingOverlay.hide();
    SignupService signupService = SignupService();
    bool result = await signupService.signup(username, email, password);
    BuildContext? context2 = Get.context;

    context2!.loaderOverlay.hide();
    toLoginScreen();
  }
}
