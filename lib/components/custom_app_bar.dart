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
        style: TextStyle(
          color: mainColor,
        ),
      ),
      leading: BackButton(
        color: lightColor,
      ),
      toolbarHeight: 80,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 4,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
