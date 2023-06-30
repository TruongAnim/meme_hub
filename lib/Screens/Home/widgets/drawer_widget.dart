import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/widgets/drawer_item.dart';
import 'package:meme_hub/Screens/Home/controllers/home_controller.dart';
import 'package:meme_hub/Screens/Home/widgets/no_tag_selected_widget.dart';
import 'package:meme_hub/models/tag.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Divider(
              thickness: 5,
              color: Colors.grey[300],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  'Interests',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _controller.clearSelectedTag,
                  child: const Text(
                    'Clear',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(height: 6),
            GetBuilder(
              id: 'selected-tag',
              builder: (HomeController controller) =>
                  controller.selectedTags.isEmpty
                      ? const NoTagSelectedWidget()
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[200],
                            thickness: 2,
                            height: 0,
                          ),
                          itemCount: _controller.selectedTags.length,
                          itemBuilder: (context, index) {
                            return DrawerItem(
                              tag: controller.selectedTags[index],
                              isSelected: true,
                              showButton: false,
                            );
                          },
                        ),
            ),
            Divider(
              thickness: 5,
              color: Colors.grey[300],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  'All tags',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                const Spacer(),
                GetBuilder(
                    id: 'selected-tag',
                    builder: (HomeController controller) {
                      return Text(
                        '${controller.selectedTags.length}/${controller.tags.length}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      );
                    }),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: GetBuilder(
                id: 'all-tag',
                builder: (HomeController controller) {
                  return controller.tags.isEmpty
                      ? Container()
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[200],
                            thickness: 2,
                            height: 0,
                          ),
                          itemCount: _controller.tags.length,
                          itemBuilder: (context, index) {
                            Tag tag = _controller.tags[index];
                            return DrawerItem(
                                tag: tag,
                                isSelected:
                                    controller.selectedTags.contains(tag),
                                showButton: true);
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
