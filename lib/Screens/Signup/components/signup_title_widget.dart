import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class SignupTitleWidget extends StatelessWidget {
  const SignupTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const SizedBox(height: 8),
        Image.asset(
          'assets/images/signup_background.png',
          fit: BoxFit.fitWidth,
          height: height * 0.4,
        ),
        const SizedBox(height: 16),
        const Text(
          'SIGN UP',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: secondaryColor),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
