import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/controllers/post_controller.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/tag_service.dart';
import 'package:meme_hub/services/user_service.dart';

class HomeController extends GetxController {
  final TagService _tagService = TagService.instance;
  RxList<Tag> selectedTags = RxList();
  RxList<Tag> tags = RxList();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    tags.value = await _tagService.getTags();
  }

  String getUserAvatar() {
    return UserService.instance.currentUser.avatar;
  }

  void toUploadScreen() async {
    await Get.toNamed(AppRoutes.upload);
  }

  void selectTag(Tag tag) {
    if (!selectedTags.contains(tag)) {
      selectedTags.add(tag);
      update(['all-tag', 'selected-tag']);
    }
  }

  void removeTag(Tag tag) {
    selectedTags.remove(tag);
    update(['all-tag', 'selected-tag']);
  }

  void clearSelectedTag() {
    selectedTags.clear();
    update(['all-tag', 'selected-tag']);
  }

  void updatePost() {
    print('updatePostTag ${selectedTags}');
    Get.find<PostController>().updateTags(selectedTags);
  }
}
