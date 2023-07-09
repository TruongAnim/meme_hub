import 'package:get/get.dart';
import 'package:meme_hub/Screens/Signup/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignupController>(SignupController());
  }
}
