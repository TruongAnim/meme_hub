import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
