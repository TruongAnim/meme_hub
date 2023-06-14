import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/home_controller.dart';

class HomeAppbar extends StatelessWidget {
  HomeAppbar({super.key});
  HomeController controller = Get.find();

  String getTagName() {
    if (controller.tags.isEmpty) {
      return 'Meme Hub';
    } else {
      return controller.tags[controller.current.value].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliderAppBar(
        title: Text(getTagName(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        trailing: GestureDetector(
          onTap: () {
            controller.toUserScreen();
          },
          child: const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
        ),
      ),
    );
  }
}
