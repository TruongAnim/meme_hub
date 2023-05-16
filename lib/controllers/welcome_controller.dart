import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';

class WelcomeController extends GetxController {
  void toLoginScreen() {
    Get.toNamed(AppRoutes.login);
  }

  void toSignupScreen() {
    Get.toNamed(AppRoutes.signup);
  }

  void toHomeScreen() {
    Get.toNamed(AppRoutes.home);
  }
}
