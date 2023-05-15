import 'package:get/get.dart';
import 'package:meme_hub/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    // Add your dependency initialization here
    Get.put<SignupController>(SignupController());
  }
}
