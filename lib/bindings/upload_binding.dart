import 'package:get/get.dart';
import 'package:meme_hub/Screens/NewPost/controllers/new_post_controller.dart';

class UploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewPostController>(NewPostController());
  }
}
