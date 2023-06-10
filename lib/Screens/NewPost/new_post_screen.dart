import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_hub/components/empty_image_holder.dart';
import 'package:meme_hub/components/tags_dropdown.dart';
import 'package:meme_hub/components/video_player_widget.dart';
import 'package:meme_hub/controllers/new_post_controller.dart';
import 'package:meme_hub/models/tag.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:meme_hub/utils/toast_maker.dart';

enum MediaType { image, video, none }

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final NewPostController _controller = Get.find();
  File? _mediaFile;
  MediaType type = MediaType.none;
  List<Tag> selectedTags = List.empty(growable: true);
  final _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();

  void _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        type = MediaType.image;
        _mediaFile = File(pickedImage.path);
      });
      print(type);
    }
  }

  void _pickVideo() async {
    final pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        type = MediaType.video;
        _mediaFile = File(pickedVideo.path);
      });
      print(type);
    }
  }

  void _uploadImage() async {
    LoadingOverlay.show();
    bool result = await _controller.post(_mediaFile, _titleController.text,
        selectedTags.map((e) => e.id).toList());
    LoadingOverlay.hide();
    if (result) {
      ToastMaker.showToast(content: 'Your meme has been post!');
      Get.back();
    } else {
      ToastMaker.showToast(content: 'Error!');
    }
  }

  void _clearMedia() {
    setState(() {
      type = MediaType.none;
      _mediaFile = null;
    });
  }

  void showPickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pick Image'),
                onTap: () async {
                  Navigator.of(context).pop();
                  _pickImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Pick Video'),
                onTap: () async {
                  Navigator.of(context).pop();
                  _pickVideo();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16.0),
              TagsDropdown(selectedTags: selectedTags),
              const SizedBox(height: 16.0),
              if (type == MediaType.image)
                Image.file(
                  _mediaFile!,
                  fit: BoxFit.cover,
                )
              else if (type == MediaType.video)
                VideoPlayerWidget(source: _mediaFile)
              else
                EmptyImageHolder(backgroundColor: Colors.grey.shade400),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: type == MediaType.none
                    ? showPickerBottomSheet
                    : _clearMedia,
                child: Text(type == MediaType.none
                    ? 'Add Image/Video'
                    : 'Remove Media'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _uploadImage();
                },
                child: const Text('Upload'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
