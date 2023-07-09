import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/Screens/Welcome/controllers/welcome_controller.dart';

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
          tag: 'btn_login',
          child: ElevatedButton(
            onPressed: () {
              controller.toLoginScreen();
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor)),
            child: Text(
              "Login".toUpperCase(),
              style: const TextStyle(color: mainColor),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            controller.toSignupScreen();
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(secondaryColor)),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
