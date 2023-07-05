import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(color: secondaryColor),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Sign Up" : "Login",
            style: const TextStyle(
              color: linkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
