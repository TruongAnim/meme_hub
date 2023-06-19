import 'package:get/get.dart';
import 'package:meme_hub/controllers/post_controller.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/tag_service.dart';
import 'package:meme_hub/utils/temp_data.dart';

class HomeController extends GetxController {
  final TagService _tagService = TagService.instance;
  RxList<Tag> tags = RxList();
  RxInt current = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    List<Tag> temp = [TempData.getTempTag()];
    temp.addAll(await _tagService.getTags());
    tags.value = temp;
  }

  void toUserScreen() {
    Get.toNamed(AppRoutes.user);
  }

  void toUploadScreen() async {
    await Get.toNamed(AppRoutes.upload);
  }

  void selectItem(int index) {
    if (index != current.value) {
      current.value = index;
      PostController postController = Get.find();
      postController.updateTag(tags[index]);
      Get.back();
    }
  }
}
