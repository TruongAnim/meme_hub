import 'package:get/get.dart';
import 'package:meme_hub/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Add your dependency initialization here
    Get.put<HomeController>(HomeController());
  }
}
