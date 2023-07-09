import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/auth_service.dart';

class LoginController extends GetxController {
  void toSignupScreen() {
    Get.offNamed(AppRoutes.signup);
  }

  void toHomeScreen() {
    Get.offAllNamed(AppRoutes.home);
  }

  Future<bool> login(String email, String password) async {
    try {
      bool result = await AuthService.instance.login(email, password);

      if (result) {
        toHomeScreen();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
