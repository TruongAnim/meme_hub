import 'dart:io';

import 'package:get/get.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/task_result.dart';

class UpdateInfoController extends GetxController {
  User currentUser = UserService.instance.currentUser;

  Future<TaskResult> updateUser(
      String name, String description, File? avatar) async {
    String? url;
    if (avatar != null) {
      url = await CloudService.instance.uploadAvatar(avatar);
    }
    TaskResult update =
        await UserService.instance.updateUserInfo(name, description, url);
    return update;
  }
}
