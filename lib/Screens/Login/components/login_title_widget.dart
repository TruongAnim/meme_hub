import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class LoginTitleWidget extends StatelessWidget {
  const LoginTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Image.asset(
          'assets/gifs/welcome_back2.gif',
          fit: BoxFit.cover,
          height: height * 0.5,
        ),
        const SizedBox(height: 16),
        const Text(
          'LOGIN',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: secondaryColor),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
