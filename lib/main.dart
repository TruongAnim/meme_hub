import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Home/home_screen.dart';
import 'package:meme_hub/Screens/Login/login_screen.dart';
import 'package:meme_hub/Screens/Signup/signup_screen.dart';
import 'package:meme_hub/Screens/Welcome/welcome_screen.dart';
import 'package:meme_hub/bindings/home_binding.dart';
import 'package:meme_hub/bindings/login_binding.dart';
import 'package:meme_hub/bindings/signup_binding.dart';
import 'package:meme_hub/bindings/welcome_binding.dart';
import 'package:meme_hub/constants.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:meme_hub/services/login_service.dart';
import 'package:meme_hub/services/signup_service.dart';
import 'package:meme_hub/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.pages,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void signup() async {
    bool result =
        await SignupService().signup('user1', 'user1@gmail.com', '123456');
    final snackBar = SnackBar(
      content: Text('This is a Snackbar $result'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void login() async {
    String? result = await LoginService().login('user1@gmail.com', '123456');
    final snackBar = SnackBar(
      content: Text('This is a Snackbar $result'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getUser() async {
    bool? result = await UserService().getUser();
    if (result) {
      final snackBar = SnackBar(
        content: Text('This is a Snackbar ${UserService.currentUser.name}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('This is a Snackbar false'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        ElevatedButton(onPressed: signup, child: Text('Signup')),
        ElevatedButton(onPressed: login, child: Text('login')),
        ElevatedButton(onPressed: getUser, child: Text('getUser'))
      ]),
    );
  }
}
