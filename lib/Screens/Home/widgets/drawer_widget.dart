import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/widgets/drawer_item.dart';
import 'package:meme_hub/Screens/Home/controllers/home_controller.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Obx(() {
      return _controller.tags.isEmpty
          ? Container()
          : ListView.builder(
              itemCount: _controller.tags.length,
              itemBuilder: (context, index) {
                return DrawerItem(index: index);
              },
            );
    }));
  }
}
