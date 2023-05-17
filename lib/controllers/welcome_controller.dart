import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/user_service.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() async {
    UserService userService = UserService();
    bool result = await userService.getUser();
    if (result) {
      toHomeScreen();
    }
    super.onInit();
  }

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
