import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_hub/Screens/Comment/controllers/comment_controller.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:meme_hub/utils/toast_maker.dart';

class CommentBox extends StatefulWidget {
  CommentBox({super.key, required this.postId});
  String postId;

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final CommentController _controller = Get.find();
  final List<XFile> _selectedImages = [];

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (_selectedImages.isNotEmpty) {
          _selectedImages[0] = image; // Replace the first item
        } else {
          _selectedImages.add(image); // Add the item to the list
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void sendComment() async {
    final String commentText = _textEditingController.text;
    final List<File> commentImages =
        _selectedImages.map((image) => File(image.path)).toList();
    LoadingOverlay.show();
    bool result = await _controller.sendComment(
        commentText, commentImages, widget.postId);
    LoadingOverlay.hide();
    if (result) {
      ToastMaker.showToast(content: 'Comment posted!');
      _textEditingController.clear();

      _selectedImages.clear();
    } else {
      ToastMaker.showToast(content: 'Error!');
    }
  }

  bool isReady() {
    if (_textEditingController.text.isNotEmpty) {
      return true;
    }
    if (_selectedImages.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < _selectedImages.length; i++)
              Stack(
                children: [
                  Image.file(
                    File(_selectedImages[i].path),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => _removeImage(i),
                    ),
                  ),
                ],
              ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter your comment',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.image),
              onPressed: _pickImage,
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: isReady() ? Colors.blue : Colors.grey,
              ),
              onPressed: isReady() ? sendComment : null,
            ),
          ],
        ),
      ],
    );
  }
}
