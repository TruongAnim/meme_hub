import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/widgets/slider_menu_item.dart';
import 'package:meme_hub/Screens/Home/controllers/slider_controller.dart';
import 'package:meme_hub/core/helpers/assets_helper.dart';
import 'package:meme_hub/core/helpers/image_helper.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({super.key});
  final SliderController _controller =
      Get.put<SliderController>(SliderController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              ImageHelper.loadFromAsset(AssetsHelper.background_avatar,
                  width: 220, height: 220),
              Obx(
                () => CircleAvatar(
                  radius: 72,
                  backgroundImage:
                      NetworkImage(_controller.currentUser.value.avatar),
                ),
              ),
            ],
          ),
          Obx(
            () => Text(
              _controller.currentUser.value.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_controller.menu.isNotEmpty)
            ..._controller.menu
                .map((menu) => SliderMenuItem(
                    title: menu.title,
                    iconData: menu.iconData,
                    onTap: menu.callback))
                .toList(),
        ],
      ),
    );
  }
}
