import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/post_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';

class NewPostController extends GetxController {
  Uint8List? _imageBytes;
  String? _imageName;
  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> post(File image, String title) async {
    try {
      String mediaLink = await CloudService.instance.uploadImage(image);
      PostService postService = PostService();
      return await postService.newPost(title, mediaLink, ['image', 'hello']);
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      return false;
    }
  }

  void toUserScreen() {
    Get.toNamed(AppRoutes.user);
  }
}
