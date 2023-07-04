import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/ChangePassword/controllers/change_password_controller.dart';
import 'package:meme_hub/components/custom_app_bar.dart';
import 'package:meme_hub/components/custom_button.dart';
import 'package:meme_hub/components/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController _controller =
      Get.find<ChangePasswordController>();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Change Password',
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              CustomTextField(
                onChanged: _controller.setCurrentPassword,
                label: 'Current Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                onChanged: _controller.setNewPassword,
                label: 'New Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                onChanged: _controller.setConfirmPassword,
                label: 'Confirm Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 16.0),
              Obx(() {
                if (_controller.errorMessage.isNotEmpty) {
                  return Text(
                    _controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return const SizedBox(); // Empty container when no error
                }
              }),
              const SizedBox(height: 16.0),
              CustomButton(
                callback: _controller.changePassword,
                title: 'Change Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
