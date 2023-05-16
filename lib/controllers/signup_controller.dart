import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';

class SignupController extends GetxController {
  void toLoginScreen() {
    Get.offNamed(AppRoutes.login);
  }

  void signup() {
    toLoginScreen();
  }
}
