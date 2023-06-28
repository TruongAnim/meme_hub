import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/ChangePassword/controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController _controller =
      Get.find<ChangePasswordController>();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: _controller.setCurrentPassword,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextFormField(
              onChanged: _controller.setNewPassword,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            TextFormField(
              onChanged: _controller.setConfirmPassword,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            Obx(() {
              if (_controller.errorMessage.isNotEmpty) {
                return Text(
                  _controller.errorMessage.value,
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return SizedBox(); // Empty container when no error
              }
            }),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _controller.changePassword,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
