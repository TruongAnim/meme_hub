import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/welcome_controller.dart';

import '../../../constants.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomeController controller = Get.find();
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              controller.toLoginScreen();
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            controller.toSignupScreen();
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
