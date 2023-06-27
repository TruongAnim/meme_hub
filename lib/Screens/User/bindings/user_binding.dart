import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
  }
}
