import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  CustomTextField({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.person_outline, color: mainColor),
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
