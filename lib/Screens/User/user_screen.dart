import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  UserScreen({
    super.key,
  });

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Token: '),
          ],
        ),
      ),
    );
  }
}
