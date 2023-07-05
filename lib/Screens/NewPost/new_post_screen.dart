import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_hub/Screens/NewPost/widgets/create_post_appbar.dart';
import 'package:meme_hub/Screens/NewPost/widgets/new_post_user_card_widget.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/components/custom_app_bar.dart';
import 'package:meme_hub/components/custom_button.dart';
import 'package:meme_hub/components/empty_image_holder.dart';
import 'package:meme_hub/components/tags_dropdown.dart';
import 'package:meme_hub/components/video_player_widget.dart';
import 'package:meme_hub/constants.dart';
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
    }
  }

  void _pickVideo() async {
    final pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        type = MediaType.video;
        _mediaFile = File(pickedVideo.path);
      });
    }
  }

  void post() async {
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
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick Image'),
                onTap: () async {
                  Navigator.of(context).pop();
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('Pick Video'),
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
      appBar: CreatePostAppbar(callback: post),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NewPostUserCardWidget(user: _controller.getCurrentUser()),
              const SizedBox(height: 16.0),
              TextField(
                maxLines: null, // Allows multiple lines
                minLines: 3,
                maxLength: 500,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                controller: _titleController,
                decoration: InputDecoration(
                    hintText: "A short and witty title does the trick.",
                    fillColor: backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    )),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: const BoxDecoration(color: lightUpvoteColor),
                child: Row(children: [
                  const SizedBox(width: defaultPadding),
                  const Text(
                    'Tag:',
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Expanded(
                    child: TagsDropdown(selectedTags: selectedTags),
                  ),
                  const SizedBox(width: defaultPadding),
                ]),
              ),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: CustomButton(
                  callback: type == MediaType.none
                      ? showPickerBottomSheet
                      : _clearMedia,
                  title: type == MediaType.none
                      ? 'Add Image/Video'
                      : 'Remove Media',
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
