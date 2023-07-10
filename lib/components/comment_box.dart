import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_hub/Screens/Comment/controllers/comment_controller.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:meme_hub/utils/toast_maker.dart';
import 'package:video_player/video_player.dart';

class CommentBox extends StatefulWidget {
  const CommentBox({super.key, required this.postId});
  final String postId;

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final CommentController _controller = Get.find();
  final List<XFile> _selectedMedia = [];
  VideoPlayerController? _videoPlayerController;
  String type = 'text';

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      type = 'image';
      setState(() {
        if (_selectedMedia.isNotEmpty) {
          _selectedMedia[0] = image; // Replace the first item
        } else {
          _selectedMedia.add(image); // Add the item to the list
        }
      });
    }
  }

  void _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        type = 'video';
        _videoPlayerController = VideoPlayerController.file(File(video.path))
          ..initialize();
        if (_selectedMedia.isNotEmpty) {
          _selectedMedia[0] = video; // Replace the first item
        } else {
          _selectedMedia.add(video); // Add the item to the list
        }
      });
    }
  }

  void _removeMedia(int index) {
    setState(() {
      type = 'text';
      _selectedMedia.removeAt(index);
    });
  }

  void sendComment() async {
    final String commentText = _textEditingController.text;
    final List<File> media =
        _selectedMedia.map((image) => File(image.path)).toList();
    LoadingOverlay.show();
    bool result =
        await _controller.sendComment(commentText, type, media, widget.postId);
    LoadingOverlay.hide();
    if (result) {
      ToastMaker.showToast(content: 'Comment posted!');
      _textEditingController.clear();
      _selectedMedia.clear();
      type = 'text';
    } else {
      ToastMaker.showToast(content: 'Error!');
    }
  }

  bool isReady() {
    if (_textEditingController.text.isNotEmpty) {
      return true;
    }
    if (_selectedMedia.isNotEmpty) {
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
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _selectedMedia.length; i++)
              Stack(
                children: [
                  if (type == 'image')
                    Image.file(
                      File(_selectedMedia[i].path),
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    )
                  else if (type == 'video')
                    SizedBox(
                        width: 75,
                        height: 75,
                        child: VideoPlayer(_videoPlayerController!))
                  else
                    Container(),
                  Positioned.fill(
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeMedia(i),
                    ),
                  ),
                ],
              ),
          ],
        ),
        _selectedMedia.isNotEmpty ? const SizedBox(height: 4) : Container(),
        Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 3,
                minLines: 1,
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: 'Enter your comment',
                    fillColor: Colors.grey[200]),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.image_outlined,
                color: secondaryColor,
              ),
              onPressed: _pickImage,
            ),
            IconButton(
              icon: const Icon(
                Icons.videocam_outlined,
                color: upvoteColor,
              ),
              onPressed: _pickVideo,
            ),
            IconButton(
              padding: EdgeInsets.all(0),
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
