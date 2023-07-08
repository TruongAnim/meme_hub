import 'package:flutter/material.dart';
import 'package:meme_hub/Theme/colors.dart';

class MediaPlaceholder extends StatelessWidget {
  final bool isLoading;
  final double aspectRatio;
  const MediaPlaceholder(
      {super.key, required this.isLoading, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
          alignment: Alignment.center,
          color: Colors.grey[300],
          child: isLoading
              ? const SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(color: secondaryColor))
              : const Icon(Icons.error, size: 100, color: secondaryColor)),
    );
  }
}
