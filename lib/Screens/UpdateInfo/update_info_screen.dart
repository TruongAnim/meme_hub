import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/UpdateInfo/controllers/update_info_controller.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/components/custom_app_bar.dart';
import 'package:meme_hub/components/custom_button.dart';
import 'package:meme_hub/components/custom_text_field.dart';
import 'package:meme_hub/models/user.dart';
import 'package:meme_hub/utils/api_constants.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:meme_hub/utils/snackbar_utils.dart';
import 'package:meme_hub/utils/task_result.dart';
import 'package:meme_hub/utils/toast_maker.dart';
import 'package:meme_hub/utils/url_utils.dart';
import 'package:path/path.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late User currentUser;
  final UpdateInfoController _controller = Get.find();
  File? avatarImage;

  @override
  void initState() {
    super.initState();
    currentUser = _controller.currentUser;
    nameController.text = currentUser.name;
    descriptionController.text = currentUser.description;
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        avatarImage = File(pickedImage.path);
      });
    }
  }

  Future<void> updateUser() async {
    final String name = nameController.text;
    final String description = descriptionController.text;
    LoadingOverlay.show();
    TaskResult result =
        await _controller.updateUser(name, description, avatarImage);
    LoadingOverlay.hide();
    if (result.isSuccess) {
      ToastMaker.showToast(content: result.title!);
      Get.back(result: TaskResult(isSuccess: true));
    } else {
      SnackbarUtils.showError(result.title, result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Update User Info',
        actions: [
          PopupMenuButton<String>(
            color: backgroundColor,
            icon: Icon(
              Icons.more_vert,
              color: lightColor,
            ),
            onSelected: (value) {
              if (value == 'change-password') {
                _controller.toChangePasswordScreen();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'change-password',
                child: Text('Change password'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              GestureDetector(
                onTap: pickImageFromGallery,
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: avatarImage != null
                        ? FileImage(avatarImage!) as ImageProvider
                        : NetworkImage(
                            UrlUtils.addPublicIfNeeded(currentUser.avatar)),
                    child: Stack(
                      children: [
                        Positioned(
                            right: -5,
                            bottom: -5,
                            child: Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: upvoteColor,
                            ))
                      ],
                    )),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: nameController,
                label: 'Nick name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: descriptionController,
                label: 'Description',
                icon: Icons.description_outlined,
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: 'Update',
                callback: updateUser,
              )
            ],
          ),
        ),
      ),
    );
  }
}
