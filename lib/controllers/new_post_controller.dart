import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/post_service.dart';
import 'package:meme_hub/utils/LogUtil.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:meme_hub/utils/toast_maker.dart';

class NewPostController extends GetxController {
  late CloudService api;
  Uint8List? _imageBytes;
  String? _imageName;
  @override
  void onInit() {
    rootBundle.loadString('assets/keys/credentials.json').then((json) {
      api = CloudService(json: json);
    });
    super.onInit();
  }

  Future<bool> post(File image, String title) async {
    try {
      LoadingOverlay.show();
      String mediaLink = await uploadImage(image);
      PostService postService = PostService();
      bool result =
          await postService.newPost(title, mediaLink, ['image', 'hello']);
      LoadingOverlay.hide();
      if (result) {
        ToastMaker.showToast(content: 'Your meme has been post!');
        Get.back();
      } else {
        ToastMaker.showToast(content: 'Error!');
      }
      return true;
    } catch (error, stackTrace) {
      LogUtil.error('login', error, stackTrace);
      LoadingOverlay.hide();
      return false;
    }
  }

  Future<String> uploadImage(File image) async {
    Uint8List _imageBytes = image.readAsBytesSync();
    String _imageName = image.path.split('/').last;
    return await api.save(_imageName, _imageBytes);
  }

  void toUserScreen() {
    Get.toNamed(AppRoutes.user);
  }
}
