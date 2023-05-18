import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/cloud_service.dart';

class UploadController extends GetxController {
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
    String imageLink = await uploadImage(image);
    print(imageLink);
    return true;
  }

  Future<String> uploadImage(File image) async {
    Uint8List _imageBytes = image.readAsBytesSync();
    String _imageName = image.path.split('/').last;

    final response = await api.save(_imageName, _imageBytes);
    return response.downloadLink.toString();
  }

  void toUserScreen() {
    Get.toNamed(AppRoutes.user);
  }
}
