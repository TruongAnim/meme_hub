import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_hub/controllers/new_post_controller.dart';
import 'package:meme_hub/services/cloud_service.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:meme_hub/utils/toast_maker.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final NewPostController _controller = Get.find();
  File? _image;
  final _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();

  void _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _uploadImage() async {
    if (_image != null) {
      LoadingOverlay.show();
      bool result = await _controller.post(_image!, _titleController.text);
      LoadingOverlay.hide();
      if (result) {
        ToastMaker.showToast(content: 'Your meme has been post!');
        Get.back();
      } else {
        ToastMaker.showToast(content: 'Error!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Choose Image'),
            ),
            const SizedBox(height: 16.0),
            _image != null
                ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    height: 200.0,
                  )
                : const Placeholder(
                    fallbackHeight: 200.0,
                  ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tags',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _uploadImage();
              },
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
