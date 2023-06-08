import 'package:get/get.dart';
import 'package:meme_hub/controllers/reply_controller.dart';

class ReplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReplyController>(ReplyController());
  }
}
