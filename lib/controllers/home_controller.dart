import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';

class HomeController extends GetxController {
  void toUserScreen() {
    Get.toNamed(AppRoutes.user);
  }

  void toUploadScreen() async {
    await Get.toNamed(AppRoutes.upload);
  }
}
