import 'package:get/get.dart';
import 'package:meme_hub/Screens/ChangePassword/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChangePasswordController>(ChangePasswordController());
  }
}
