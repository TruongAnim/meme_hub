import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/drawer_item.dart';
import 'package:meme_hub/controllers/home_controller.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.tags.isEmpty
          ? Container()
          : ListView.builder(
              itemCount: _controller.tags.length,
              itemBuilder: (context, index) {
                return DrawerItem(index: index);
              },
            );
    });
  }
}
