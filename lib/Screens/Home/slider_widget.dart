import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/slider_menu_item.dart';
import 'package:meme_hub/controllers/slider_controller.dart';

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
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: Image.network(
                      'https://nikhilvadoliya.github.io/assets/images/nikhil_1.webp')
                  .image,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Nick',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
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
