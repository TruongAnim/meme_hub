import 'package:get/get.dart';
import 'package:meme_hub/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
