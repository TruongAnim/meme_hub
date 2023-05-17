import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/controllers/login_controller.dart';
import 'package:meme_hub/utils/toast_maker.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginController controller = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // Call API or perform other operations with the form data
      bool result = await controller.login(email, password);
      // Reset the form fields
      if (result) {
        _emailController.clear();
        _passwordController.clear();
      } else {
        ToastMaker.showToast(content: 'Sign up false!!!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.find();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              // Add email validation logic if needed
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                // Add password validation logic if needed
                return null;
              },
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              controller.toSignupScreen();
            },
          ),
        ],
      ),
    );
  }
}
