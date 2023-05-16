import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';

class LoginController extends GetxController {
  void toSignupScreen() {
    Get.offNamed(AppRoutes.signup);
  }

  void toHomeScreen() {
    Get.offAllNamed(AppRoutes.home);
  }

  void login() {
    toHomeScreen();
  }
}
