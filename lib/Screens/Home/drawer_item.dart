import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/home_controller.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/utils/api_constants.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({
    super.key,
    required this.index,
  });
  int index;
  HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Tag tag = _controller.tags[index];
    return Obx(() {
      bool isActive = index == _controller.current.value;
      return InkWell(
        onTap: () => _controller.selectItem(index),
        child: ListTile(
          horizontalTitleGap: 10,
          textColor: Colors.black54,
          tileColor: isActive ? Colors.green : Colors.white30,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25)), // Rounded corners
          ),
          leading: Image.network(
              width: 25, height: 25, ApiConstants.public + tag.icon),
          title: Text(tag.name),
          trailing: Container(
              width: 30,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Center(child: Text(tag.posts.length.toString()))),
        ),
      );
    });
  }
}
