import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  Function(String)? onChanged;
  String label;
  IconData icon;
  CustomTextField(
      {super.key,
      this.controller,
      this.onChanged,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: mainColor),
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
