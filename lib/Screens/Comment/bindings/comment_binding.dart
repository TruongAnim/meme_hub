import 'package:get/get.dart';
import 'package:meme_hub/Screens/Comment/controllers/comment_controller.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CommentController>(CommentController());
  }
}
