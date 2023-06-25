import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
import 'package:meme_hub/core/helpers/assets_helper.dart';
import 'package:meme_hub/core/helpers/image_helper.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/url_utils.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});
  final UserController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ImageHelper.loadFromAsset(AssetsHelper.background_avatar,
                  width: 220, height: 220),
              Obx(
                () => CircleAvatar(
                  radius: 72,
                  backgroundImage: NetworkImage(
                      UrlUtils.addPublicIfNeeded(_controller.user.avatar)),
                ),
              ),
            ],
          ),
          Obx(
            () => Text(
              _controller.user.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Obx(
            () => Text(
              _controller.user.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
