import 'package:get/get.dart';
import 'package:meme_hub/controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    // Add your dependency initialization here
    Get.put<UserController>(UserController());
  }
}
