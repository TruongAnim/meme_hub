import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/controllers/home_controller.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/utils/api_constants.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({
    super.key,
    required this.tag,
    required this.isSelected,
    required this.showButton,
  });
  Tag tag;
  bool isSelected;
  bool showButton;
  final HomeController _controller = Get.find();

  Widget getTrailing() {
    if (showButton) {
      if (isSelected) {
        return IconButton(
            onPressed: () {
              _controller.removeTag(tag);
            },
            icon: Icon(Icons.remove));
      } else {
        return IconButton(
            onPressed: () {
              _controller.selectTag(tag);
            },
            icon: Icon(Icons.add));
      }
    } else {
      return ChoiceChip(
        label: Text(
          '${tag.posts.length} meme',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.transparent,
        shape: const StadiumBorder(side: BorderSide(color: Colors.grey)),
        selected: false,
        onSelected: (bool selected) {
          if (isSelected) {
            _controller.removeTag(tag);
          } else {
            _controller.selectTag(tag);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        textColor: Colors.black54,
        selectedTileColor: Colors.green[50],
        selected: isSelected,
        leading: Image.network(
            width: 25, height: 25, ApiConstants.public + tag.icon),
        title: Text(tag.name),
        trailing: getTrailing());
  }
}
