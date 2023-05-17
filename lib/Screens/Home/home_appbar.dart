import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/home_controller.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return AppBar(
      title: Text('Hello'),
      actions: [
        GestureDetector(
          onTap: () {
            controller.toUserScreen();
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
