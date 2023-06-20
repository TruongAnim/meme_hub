import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/user_service.dart';
import 'package:meme_hub/utils/task_result.dart';
import 'package:meme_hub/utils/temp_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu {
  final IconData iconData;
  final String title;
  final Function callback;

  Menu(this.iconData, this.title, this.callback);
}

class SliderController extends GetxController {
  late List<Menu> menu;
  Rx<User> currentUser = Rx(TempData.getTempUser());

  @override
  void onInit() {
    super.onInit();
    menu = [
      Menu(Icons.video_collection, 'My Collection', onMyCollectionTap),
      Menu(Icons.info, 'Update Info', onUpdateInfoTap),
      Menu(Icons.notifications_active, 'Notification', onNotificationTap),
      Menu(Icons.insert_chart, 'Statistics', onStatisticsTap),
      Menu(Icons.settings, 'Setting', onSettingTap),
      Menu(Icons.arrow_back_ios, 'LogOut', onLogoutTap)
    ];
    currentUser.value = UserService.instance.currentUser;
  }

  void onMyCollectionTap() {}

  void onUpdateInfoTap() async {
    TaskResult? result = await Get.toNamed(AppRoutes.updateInfo) as TaskResult?;
    print(result);
    if (result != null && result.isSuccess) {
      currentUser.value = UserService.instance.currentUser;
      print('update');
    }
  }

  void onNotificationTap() {}

  void onStatisticsTap() {}

  void onSettingTap() {}

  void onLogoutTap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed(AppRoutes.welcome);
  }
}
