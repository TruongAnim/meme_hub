import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_hub/Screens/Post/controllers/post_controller.dart';
import 'package:meme_hub/Theme/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String source;
  final Widget placeholder;
  const VideoPlayerWidget(
      {super.key, required this.source, required this.placeholder});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late PostController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
    _videoController = VideoPlayerController.network(widget.source);
    _videoController.initialize().then((_) {
      setState(() {});
    });
    _videoController.addListener(() {
      if (_videoController.value.isPlaying != isPlaying) {
        setState(() {
          isPlaying = _videoController.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
  }

  void _pausePlayer() {
    try {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_videoController.value.isInitialized)
          AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VisibilityDetector(
                key: Key(widget.source),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction < 0.5 &&
                      _videoController.value.isPlaying) {
                    _pausePlayer();
                  }
                },
                child: VideoPlayer(_videoController)),
          )
        else
          widget.placeholder,
        Positioned.fill(
          child: GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 80,
                  color: isPlaying
                      ? Colors.white.withOpacity(0.3)
                      : secondaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
