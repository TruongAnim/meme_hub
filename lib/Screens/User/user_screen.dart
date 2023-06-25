import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/User/controllers/user_controller.dart';
import 'package:meme_hub/Screens/User/widgets/header_widget.dart';
import 'package:meme_hub/models/user.dart';

class UserScreen extends StatelessWidget {
  UserScreen({
    super.key,
  });
  final UserController _controller =
      Get.put(UserController(userId: Get.arguments['userId']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [HeaderWidget()],
    ));
  }
}
