import 'package:flutter/material.dart';
import 'package:meme_hub/Screens/Signup/components/signup_title_widget.dart';
import 'package:meme_hub/components/background.dart';
import 'package:meme_hub/components/responsive.dart';
import 'package:meme_hub/constants.dart';
import 'components/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: Responsive(
        mobile: MobileSignupScreen(),
        desktop: DesktopSignupScreen(),
      ),
    );
  }
}

class DesktopSignupScreen extends StatelessWidget {
  const DesktopSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 450,
                child: SignUpForm(),
              ),
              SizedBox(height: defaultPadding / 2),
              // SocalSignUp()
            ],
          ),
        )
      ],
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SignupTitleWidget(),
          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 8,
                child: SignUpForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
