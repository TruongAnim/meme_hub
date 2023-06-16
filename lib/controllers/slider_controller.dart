import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu {
  final IconData iconData;
  final String title;
  final Function callback;

  Menu(this.iconData, this.title, this.callback);
}

class SliderController extends GetxController {
  late List<Menu> menu;

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
  }

  void onMyCollectionTap() {}

  void onUpdateInfoTap() {}

  void onNotificationTap() {}

  void onStatisticsTap() {}

  void onSettingTap() {}

  void onLogoutTap() async {
    print('log out');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed(AppRoutes.welcome);
  }
}
