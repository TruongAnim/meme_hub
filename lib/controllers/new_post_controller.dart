import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/post_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:mime/mime.dart';

class NewPostController extends GetxController {
  Uint8List? _imageBytes;
  String? _imageName;
  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> post(
      File? image, String title, String type, List<String> tags) async {
    try {
      String type = 'text';
      String mediaLink = '';
      if (image != null) {
        String? mimeType = lookupMimeType(image.path);
        type = mimeType!.split('/')[0];
        mediaLink = await CloudService.instance.uploadImage(image);
      }
      return await PostService.instance.newPost(title, mediaLink, type, tags);
    } catch (error, stackTrace) {
      LogUtil.error('new post', error, stackTrace);
      return false;
    }
  }

  void toUserScreen() {
    Get.toNamed(AppRoutes.user);
  }
}
