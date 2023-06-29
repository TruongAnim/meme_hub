import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/widgets/drawer_item.dart';
import 'package:meme_hub/Screens/Home/controllers/home_controller.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Obx(
          () {
            return _controller.selectedTags.isEmpty
                ? Container()
                : ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[200],
                      thickness: 2,
                      height: 0,
                    ),
                    itemCount: _controller.selectedTags.length,
                    itemBuilder: (context, index) {
                      return DrawerItem(
                          tag: _controller.selectedTags[index],
                          isSelected: true);
                    },
                  );
          },
        ),
        Expanded(
          child: Obx(
            () {
              return _controller.tags.isEmpty
                  ? Container()
                  : ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[200],
                        thickness: 2,
                        height: 0,
                      ),
                      itemCount: _controller.tags.length,
                      itemBuilder: (context, index) {
                        return DrawerItem(
                            tag: _controller.tags[index], isSelected: false);
                      },
                    );
            },
          ),
        ),
      ]),
    );
  }
}
