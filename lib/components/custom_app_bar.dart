import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final List<Widget> actions;
  const CustomAppBar({super.key, required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: mainColor,
        ),
      ),
      leading: const BackButton(
        color: lightColor,
      ),
      toolbarHeight: 80,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 4,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: actions,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
