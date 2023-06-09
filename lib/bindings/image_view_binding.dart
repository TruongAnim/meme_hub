import 'package:get/get.dart';
import 'package:meme_hub/controllers/image_view_controller.dart';

class ImageViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ImageViewController>(ImageViewController());
  }
}
