import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meme_hub/utils/loading_overlay.dart';
import 'package:photo_view/photo_view.dart';

import 'package:meme_hub/controllers/image_view_controller.dart';

class ImageViewScreen extends StatefulWidget {
  ImageViewScreen();

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final ImageViewController _controller = Get.find();
  final DateFormat formatter = DateFormat('HH:mm:ss dd-MM-yyyy');
  late String name;
  late DateTime time;
  late String url;

  @override
  void initState() {
    super.initState();
    name = Get.arguments['name'];
    time = Get.arguments['time'];
    url = Get.arguments['url'];
  }

  void _download() async {
    LoadingOverlay.show();
    await _controller.download(url);
    LoadingOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PhotoView(
              imageProvider: NetworkImage(url),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  formatter.format(time),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: _download,
              child: Text('Download'),
            ),
          )
        ],
      ),
    );
  }
}
