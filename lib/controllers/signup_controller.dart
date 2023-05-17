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

  Future<bool> signup(String username, String email, String password) async {
    try {
      LoadingOverlay.show();
      SignupService signupService = SignupService();
      bool result = await signupService.signup(username, email, password);
      LoadingOverlay.hide();

      if (result) {
        toLoginScreen();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
