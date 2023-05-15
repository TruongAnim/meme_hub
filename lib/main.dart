import 'package:flutter/material.dart';
import 'package:meme_hub/services/login_service.dart';
import 'package:meme_hub/services/signup_service.dart';
import 'package:meme_hub/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Home page'),
          ),
          body: const MyHomePage()),
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
