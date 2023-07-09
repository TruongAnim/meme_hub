import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/auth_service.dart';

class SignupController extends GetxController {
  void toLoginScreen() {
    Get.offNamed(AppRoutes.login);
  }

  Future<bool> signup(String username, String email, String password) async {
    try {
      return await AuthService.instance.signup(username, email, password);
    } catch (e) {
      return false;
    }
  }
}
