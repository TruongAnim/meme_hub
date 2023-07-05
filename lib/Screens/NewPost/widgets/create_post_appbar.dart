import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Theme/colors.dart';

class CreatePostAppbar extends StatelessWidget implements PreferredSize {
  final Function() callback;
  const CreatePostAppbar({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Create post',
        style: TextStyle(color: mainColor),
      ),
      toolbarHeight: 80,
      backgroundColor: backgroundColor,
      elevation: 4,
      leading: IconButton(
        icon: const Icon(Icons.close, color: lightColor),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          width: 70,
          child: ElevatedButton(
            onPressed: callback,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(linkColor)),
            child: const Text(
              'Post',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
