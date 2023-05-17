import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/login_service.dart';
import 'package:meme_hub/utils/loading_overlay.dart';

class LoginController extends GetxController {
  void toSignupScreen() {
    Get.offNamed(AppRoutes.signup);
  }

  void toHomeScreen() {
    Get.offAllNamed(AppRoutes.home);
  }

  Future<bool> login(String email, String password) async {
    try {
      LoadingOverlay.show();
      LoginService loginService = LoginService();
      bool result = await loginService.login(email, password);
      LoadingOverlay.hide();

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
