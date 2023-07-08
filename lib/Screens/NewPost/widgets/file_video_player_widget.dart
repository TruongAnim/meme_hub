import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/NewPost/controllers/new_post_controller.dart';
import 'package:video_player/video_player.dart';

class FileVideoPlayerWidget extends StatefulWidget {
  final File source;
  const FileVideoPlayerWidget({super.key, required this.source});

  @override
  _FileVideoPlayerWidgetState createState() => _FileVideoPlayerWidgetState();
}

class _FileVideoPlayerWidgetState extends State<FileVideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late NewPostController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
    _videoController = VideoPlayerController.file(widget.source);
    _videoController.initialize().then((_) {
      _controller.setMediaAspectRatio(_videoController.value.aspectRatio);
      setState(() {});
    });
    _videoController.addListener(() {
      if (!_videoController.value.isPlaying &&
          _videoController.value.duration == _videoController.value.position) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    print('dispose video');
    _videoController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      } else {
        _videoController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : Container(),
        Positioned.fill(
          child: GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  _videoController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
