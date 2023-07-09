import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class CustomLabelButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const CustomLabelButton(
      {super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(secondaryColor)),
      onPressed: callback,
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
