import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class CustomButton extends StatelessWidget {
  String title;
  VoidCallback callback;
  CustomButton({super.key, required this.title, required this.callback});

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
