import 'package:get/get.dart';
import 'package:meme_hub/controllers/welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    // Add your dependency initialization here
    Get.put<WelcomeController>(WelcomeController());
  }
}
