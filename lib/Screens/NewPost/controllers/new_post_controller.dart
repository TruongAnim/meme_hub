import 'dart:io';

import 'package:get/get.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/post_service.dart';
import 'package:meme_hub/services/tag_service.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:mime/mime.dart';

class NewPostController extends GetxController {
  RxList<Tag> tags = RxList();
  double _mediaAspectRatio = 1;

  @override
  void onInit() {
    super.onInit();
    loadingTags();
  }

  User getCurrentUser() {
    return UserService.instance.currentUser;
  }

  void setMediaAspectRatio(double aspectRatio) {
    _mediaAspectRatio = aspectRatio;
  }

  Future<bool> post(File? image, String title, List<String> tags) async {
    try {
      String type = 'text';
      String mediaLink = '';
      if (image != null) {
        String? mimeType = lookupMimeType(image.path);
        type = mimeType!.split('/')[0];
        mediaLink = await CloudService.instance.uploadMedia(image);
      }
      return await PostService.instance
          .newPost(title, mediaLink, type, tags, _mediaAspectRatio);
    } catch (error, stackTrace) {
      LogUtil.error('new post', error, stackTrace);
      return false;
    }
  }

  void loadingTags() async {
    tags.value = await TagService.instance.getTags();
  }
}
