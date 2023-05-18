import 'package:get/get.dart';
import 'package:meme_hub/controllers/home_controller.dart';
import 'package:meme_hub/controllers/upload_controller.dart';

class UploadBinding extends Bindings {
  @override
  void dependencies() {
    // Add your dependency initialization here
    Get.put<UploadController>(UploadController());
  }
}
