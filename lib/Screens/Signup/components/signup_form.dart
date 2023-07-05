import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/controllers/signup_controller.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:meme_hub/utils/toast_maker.dart';

import '../../Login/components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  SignupController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform signup logic here

      String name = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      LoadingOverlay.show();
      bool result = await controller.signup(name, email, password);
      LoadingOverlay.hide();
      if (result) {
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        ToastMaker.showToast(content: 'Sign up successfully!!!');
        controller.toLoginScreen();
      } else {
        ToastMaker.showToast(content: 'Sign up false!!!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: secondaryColor,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your nickname';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Your nickname",
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(
                  Icons.person,
                  color: mainColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: emailController,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              // Add email validation logic if needed
              return null;
            },
            cursorColor: secondaryColor,
            decoration: InputDecoration(
              hintText: "Your email",
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(
                  Icons.email,
                  color: mainColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "Your password",
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock, color: mainColor),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: 'btn_signup',
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor)),
              child: Text("Sign Up".toUpperCase()),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              controller.toLoginScreen();
            },
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
