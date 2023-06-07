import 'package:get/get.dart';

import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/signup_service.dart';
import 'package:meme_hub/utils/loading_overlay.dart';

class SignupController extends GetxController {
  void toLoginScreen() {
    Get.offNamed(AppRoutes.login);
  }

  Future<bool> signup(String username, String email, String password) async {
    try {
      SignupService signupService = SignupService();
      return await signupService.signup(username, email, password);
    } catch (e) {
      return false;
    }
  }
}
