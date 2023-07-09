import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class CustomIconLabelButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final Widget icon;
  const CustomIconLabelButton(
      {super.key,
      required this.title,
      required this.callback,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(secondaryColor)),
      onPressed: callback,
      icon: icon,
      label: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
